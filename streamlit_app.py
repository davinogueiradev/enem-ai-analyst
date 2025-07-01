import asyncio
import json
import os
import re
import uuid

import pandas as pd
import streamlit as st
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.genai import types

from enem_ai_analyst import config_manager
from enem_ai_analyst.agent import root_agent
from enem_ai_analyst.tools.postgres_mcp import list_tables_and_schemas

# --- Helper Functions ---

def display_message_content(message_text):
    """Display message content, rendering text and charts in order."""
    # Regex to find vega-lite or JSON code blocks and the text around them
    pattern = r'(.*?)(```(?:json|vega-lite)\n(.*?)\n```)'

    # Find all matches
    matches = re.findall(pattern, message_text, re.DOTALL)
    
    # Keep track of where the last match ended
    last_end = 0
    
    if not matches:
        # If no charts are found, just display the whole message
        st.markdown(message_text)
        return

    # Iterate through matches and render content
    for i, (pre_text, full_chart_block, chart_json_str) in enumerate(matches):
        # Display the text that came before the chart
        if pre_text.strip():
            st.markdown(pre_text)

        # Process and display the chart
        try:
            chart_json = json.loads(chart_json_str.strip())

            # Determine if the JSON is a raw Vega-Lite spec or our custom wrapper
            if "chart_spec" in chart_json:
                # It's the wrapper format
                chart_spec = chart_json.get("chart_spec", {})
                filterable_columns = chart_json.get("filterable_columns", [])
            else:
                # Assume it's a raw Vega-Lite spec
                chart_spec = chart_json
                filterable_columns = [] # No filtering for raw specs

            if not chart_spec:
                # Log error for debugging, but don't show to user unless critical
                # st.error("Chart specification is missing.")
                continue

            data = pd.DataFrame(chart_spec.get("data", {}).get("values", []))

            # If data is embedded and there are columns to filter on, show filters
            if not data.empty and filterable_columns:
                st.sidebar.title(f"Chart Filters")

                filtered_data = data.copy()

                for col in filterable_columns:
                    if col in data.columns:
                        unique_values = data[col].unique()

                        selected_values = st.sidebar.multiselect(
                            label=f"Filter by {col}",
                            options=unique_values,
                            default=unique_values,
                            key=f"filter_{i}_{col}"
                        )

                        filtered_data = filtered_data[filtered_data[col].isin(selected_values)]

                # To avoid ambiguity when providing a filtered dataframe,
                # create a spec without the original data.
                spec_for_render = chart_spec.copy()
                if 'data' in spec_for_render:
                    del spec_for_render['data']

                st.vega_lite_chart(filtered_data, spec_for_render, use_container_width=True)
            else:
                # For non-filterable charts (no filterable_columns) or charts
                # with data from a URL (data is empty), render the spec directly.
                st.vega_lite_chart(chart_spec, use_container_width=True)

        except json.JSONDecodeError as e:
            st.error(f"Failed to parse chart JSON: {e}")
            st.code(chart_json_str, language="json")
        except Exception as e:
            st.error(f"Failed to render chart {i+1}: {e}")
            st.json(chart_json)
        
        # Update the position of the last match
        last_end = message_text.find(full_chart_block, last_end) + len(full_chart_block)

    # Display any remaining text after the last chart
    remaining_text = message_text[last_end:].strip()
    if remaining_text:
        st.markdown(remaining_text)

def _setup_page():
    """Sets up the Streamlit page configuration and initializes the config database."""
    st.set_page_config(page_title="AI Data Analyst", layout="wide")
    config_manager.initialize_db()

def _render_sidebar_connection_selector(configs):
    """Renders the dropdown for selecting an active database connection."""
    st.sidebar.title("Database Connections")
    st.sidebar.caption("Select or manage your database connections.")

    # Use session state to keep track of selected config
    if "selected_config_name" not in st.session_state:
        st.session_state.selected_config_name = configs[0] if configs else None

    # Dropdown to select a configuration
    selected_name = st.sidebar.selectbox(
        "Active Connection",
        options=configs,
        index=configs.index(st.session_state.selected_config_name) if st.session_state.selected_config_name in configs else 0,
        key="selected_config_name"
    )
    return selected_name

def _render_sidebar_connection_crud(selected_name, configs):
    """Renders the UI for adding, editing, and deleting database connections."""
    # CRUD operations in an expander
    with st.sidebar.expander("Manage Connections"):
        _add_new_connection_form(configs)
        if selected_name:
            _edit_delete_connection_form(selected_name)

def _add_new_connection_form(configs):
    """Renders the form for adding a new database connection."""
    with st.form("new_config_form"):
        st.subheader("Add New Connection")
        new_name = st.text_input("Connection Name", key="new_name")
        new_host = st.text_input("Host", "localhost", key="new_host")
        new_port = st.text_input("Port", "5432", key="new_port")
        new_db = st.text_input("Database", "enem_data", key="new_db")
        new_user = st.text_input("Username", "user", key="new_user")
        new_pass = st.text_input("Password", type="password", key="new_pass")
        submitted_new = st.form_submit_button("Save New Connection")

        if submitted_new:
            if not all([new_name, new_host, new_port, new_db, new_user, new_pass]):
                st.error("All fields are required.")
            elif new_name in configs:
                st.error("A connection with this name already exists.")
            else:
                try:
                    config_manager.add_config(new_name, new_host, int(new_port), new_db, new_user, new_pass)
                    st.success(f"Connection '{new_name}' added successfully.")
                    st.session_state.selected_config_name = new_name
                    st.rerun()
                except Exception as e:
                    st.error(f"Failed to add connection: {e}")

def _edit_delete_connection_form(selected_name):
    """Renders the form for editing and deleting an existing database connection."""
    st.markdown("---")
    st.subheader(f"Edit '{selected_name}'")

    current_config_for_edit = config_manager.get_config_by_name(selected_name)
    if not current_config_for_edit:
        st.warning(f"Connection '{selected_name}' may have been deleted or failed to load.")
        st.session_state.selected_config_name = None
        st.rerun()
        return

    _render_schema_management(selected_name, current_config_for_edit)
    _render_connection_details_form(selected_name, current_config_for_edit)

def _render_schema_management(selected_name, config):
    """Renders the schema loading button and logic."""
    st.markdown("**Database Schema**")
    # Temporarily set env vars for the 'list_tables_and_schemas' tool to work
    os.environ["POSTGRES_HOST"] = config['db_host']
    os.environ["POSTGRES_PORT"] = str(config['db_port'])
    os.environ["POSTGRES_DB"] = config['db_name']
    os.environ["POSTGRES_USER"] = config['db_user']
    os.environ["POSTGRES_PASSWORD"] = config['db_password']

    if st.button(f"Load/Reload Schema for '{selected_name}'"):
        with st.spinner("Loading schema..."):
            try:
                schema = list_tables_and_schemas()
                config_manager.update_schema_and_context(
                    name=selected_name,
                    db_schema=schema,
                    data_context=config.get('data_context', '')
                )
                st.success("Schema loaded and saved successfully.")
                st.rerun()
            except Exception as e:
                st.error(f"DB Connection Error: {e}")

def _render_connection_details_form(selected_name, current_config):
    """Renders the form fields for editing connection details and data context."""
    with st.form(f"edit_config_form_{selected_name}"): # Unique key for form
        st.markdown("**Connection Details & Data Context**")
        edit_name = st.text_input("Connection Name", value=current_config['name'], key=f"edit_name_{selected_name}")
        edit_host = st.text_input("Host", value=current_config['db_host'], key=f"edit_host_{selected_name}")
        edit_port = st.text_input("Port", value=current_config['db_port'], key=f"edit_port_{selected_name}")
        edit_db = st.text_input("Database", value=current_config['db_name'], key=f"edit_db_{selected_name}")
        edit_user = st.text_input("Username", value=current_config['db_user'], key=f"edit_user_{selected_name}")
        edit_pass = st.text_input("New Password", type="password", help="Leave blank to keep current password", key=f"edit_pass_{selected_name}")

        edit_context = st.text_area(
            "Data Context",
            value=current_config.get("data_context", ""),
            help="Provide details about the data, tables, and columns to help the AI understand the context.",
            key=f"edit_context_{current_config['name']}"
        )

        col1, col2 = st.columns(2)
        with col1:
            submitted_edit = st.form_submit_button("Update Connection")
        with col2:
            submitted_delete = st.form_submit_button("Delete Connection", type="primary")

        if submitted_edit:
            _handle_update_connection(selected_name, edit_name, edit_host, edit_port, edit_db, edit_user, edit_pass, edit_context)
        if submitted_delete:
            _handle_delete_connection(selected_name)

def _handle_update_connection(original_name, name, host, port, db, user, password, context):
    """Handles the logic for updating a database connection."""
    try:
        config_manager.update_config(
            original_name=original_name,
            name=name,
            db_host=host,
            db_port=int(port),
            db_name=db,
            db_user=user,
            db_password=password if password else None,
            data_context=context
        )
        st.success(f"Connection '{name}' updated.")
        st.session_state.selected_config_name = name
        st.rerun()
    except Exception as e:
        st.error(f"Failed to update connection: {e}")

def _handle_delete_connection(name):
    """Handles the logic for deleting a database connection."""
    try:
        config_manager.delete_config(name)
        st.success(f"Connection '{name}' deleted.")
        st.session_state.selected_config_name = None
        st.rerun()
    except Exception as e:
        st.error(f"Failed to delete connection: {e}")

def _get_and_set_active_db_config(selected_name):
    """Loads the active configuration and sets environment variables."""
    active_config = None
    if selected_name:
        active_config = config_manager.get_config_by_name(selected_name)
        if active_config:
            os.environ["POSTGRES_HOST"] = active_config['db_host']
            os.environ["POSTGRES_PORT"] = str(active_config['db_port'])
            os.environ["POSTGRES_DB"] = active_config['db_name']
            os.environ["POSTGRES_USER"] = active_config['db_user']
            os.environ["POSTGRES_PASSWORD"] = active_config['db_password']
        else:
            st.error(f"Could not load configuration '{selected_name}'. It may have been deleted.")
            st.session_state.selected_config_name = None # Reset selected config
            st.rerun() # Rerun to update UI
    return active_config

def _display_sidebar_active_config_info(active_config):
    """Displays the schema and data context for the active connection in the sidebar."""
    st.sidebar.markdown("---")
    if active_config:
        st.sidebar.subheader("Active Connection Details")
        if active_config.get("db_schema"):
            with st.sidebar.expander("View Loaded Schema", expanded=False):
                st.code(active_config["db_schema"])
        else:
            st.sidebar.caption("Schema not loaded for this connection. Load it from 'Manage Connections'.")

        st.sidebar.markdown("**Data Context:**")
        if active_config.get("data_context"):
            st.sidebar.text_area(
                "Current Data Context",
                value=active_config["data_context"],
                height=150,
                disabled=True, # Make it read-only here
                key=f"display_context_{active_config['name']}"
            )
        else:
            st.sidebar.caption("No data context provided for this connection.")
    else:
        st.sidebar.warning("Please select or create a database connection to proceed.")

def _initialize_chat_components():
    """Initializes session state for chat messages and the ADK runner."""
    st.title("🤖 AI Data Analyst")
    st.caption("Ask me anything about your data!")

    # --- Constants ---
    APP_NAME = "ai_data_analyst_app"
    
    # Initialize dynamic USER_ID and SESSION_ID if not already set
    if "user_id" not in st.session_state:
        st.session_state["user_id"] = str(uuid.uuid4())

    # If a chat is selected from history, use that session_id, otherwise generate a new one.
    # "selected_session_id" will be set by the chat history UI.
    # "current_chat_session_id" is the session_id for the *active* chat window.
    if "selected_session_id" in st.session_state and st.session_state.selected_session_id:
        if "current_chat_session_id" not in st.session_state or \
           st.session_state.current_chat_session_id != st.session_state.selected_session_id:
            st.session_state.current_chat_session_id = st.session_state.selected_session_id
            # Clear messages to force reload for the selected session
            if "messages" in st.session_state:
                del st.session_state["messages"]
    elif "current_chat_session_id" not in st.session_state:
        st.session_state["current_chat_session_id"] = str(uuid.uuid4())

    current_user_id = st.session_state["user_id"]
    current_session_id = st.session_state["current_chat_session_id"] # Use the active session ID

    # Initialize session state for messages and runner
    if "messages" not in st.session_state:
        # Load chat history if available for the current_session_id
        history = config_manager.get_chat_history(current_session_id)
        if history:
            st.session_state["messages"] = history
        else:
            st.session_state["messages"] = []

    # The runner needs to be associated with the current_chat_session_id.
    # If the session_id changes, we might need to re-initialize or update the runner's session.
    # For ADK InMemorySessionService, creating a session with an existing ID should be fine
    # or it might retrieve the existing one. If not, this part might need adjustment.
    if "runner" not in st.session_state or \
       st.session_state.get("runner_session_id") != current_session_id:
        session_service = InMemorySessionService()
        asyncio.run(session_service.create_session(app_name=APP_NAME, user_id=current_user_id, session_id=current_session_id))
        st.session_state["runner"] = Runner(agent=root_agent, app_name=APP_NAME, session_service=session_service)
        st.session_state["runner_session_id"] = current_session_id


def _display_chat_history():
    """Displays all messages in the chat history."""
    # Ensure messages are loaded for the current chat session
    # This check might be redundant if _initialize_chat_components handles it thoroughly
    if st.session_state.get("current_chat_session_id") and \
       (not st.session_state.get("messages") or \
        st.session_state.messages[0].get("session_id_ref") != st.session_state.current_chat_session_id): # Crude check

        # This part is tricky: messages in st.session_state.messages don't currently store their session_id.
        # We rely on _initialize_chat_components to load the correct messages.
        # If messages are empty, _initialize_chat_components should load them.
        # If they are from a different session, _initialize_chat_components should clear and reload.
        pass # Relying on initialization logic for now.

    for message in st.session_state.get("messages", []):
        with st.chat_message(message["role"]):
            display_message_content(message["content"])

def _process_user_prompt(prompt, active_config):
    """Processes a user's chat prompt and gets a response from the AI."""
    current_session_id = st.session_state["current_chat_session_id"]
    # Add user message to history and display it
    st.session_state["messages"].append({"role": "user", "content": prompt})
    config_manager.add_chat_message(current_session_id, "user", prompt) # Save user message
    with st.chat_message("user"):
        st.markdown(prompt)

    # Get and display assistant response
    with st.chat_message("assistant"):
        with st.spinner("Thinking..."):
            if not active_config:
                st.error("Please select an active database connection in the sidebar.")
            elif not active_config.get("db_schema"):
                st.error("Please load the database schema first for the selected connection.")
            else:
                structured_input = json.dumps({
                    "user_request": prompt,
                    "data_context": active_config.get('data_context', '')
                })
                content = types.Content(role="user", parts=[types.Part(text=structured_input)])
                runner = st.session_state["runner"]
                # Ensure runner is using the correct session_id from current_chat_session_id
                events = runner.run(user_id=st.session_state["user_id"], session_id=st.session_state["current_chat_session_id"], new_message=content)

                full_response = ""
                for event in events:
                    if event.is_final_response() and event.content:
                        for part in event.content.parts:
                            full_response += part.text

                if full_response:
                    display_message_content(full_response)
                    st.session_state["messages"].append({"role": "assistant", "content": full_response})
                    config_manager.add_chat_message(st.session_state["current_chat_session_id"], "assistant", full_response) # Save assistant message
                else:
                    st.error("Sorry, I couldn't generate a response.")

# --- Sidebar: Chat History Display ---
def _render_sidebar_chat_history():
    """Renders the chat history list in the sidebar."""
    st.sidebar.markdown("---")
    st.sidebar.title("Chat History")

    if st.sidebar.button("➕ New Chat", key="new_chat_button"):
        # Generate a new session ID for the new chat
        new_session_id = str(uuid.uuid4())
        st.session_state.current_chat_session_id = new_session_id
        st.session_state.selected_session_id = new_session_id # Ensure this new chat is "selected"

        # Clear existing messages from session state to start fresh
        if "messages" in st.session_state:
            del st.session_state["messages"]

        # Potentially clear other session-specific states if necessary
        # e.g. if runner holds onto old session data in a problematic way
        if "runner" in st.session_state: # Force re-initialization of runner for the new session
            del st.session_state["runner"]
            if "runner_session_id" in st.session_state:
                 del st.session_state["runner_session_id"]

        st.rerun() # Rerun to reflect the new chat state

    chat_sessions = config_manager.get_chat_sessions_preview()

    if not chat_sessions:
        st.sidebar.caption("No past chats found.")
        return

    for session in chat_sessions:
        session_id = session["session_id"]
        preview = session["preview_content"]
        timestamp = session["timestamp"]

        # Display a more user-friendly representation
        # Using a button for each chat history item
        button_label = f"{preview} ({timestamp.split('.')[0]})" # Show timestamp without milliseconds
        if st.sidebar.button(button_label, key=f"chat_{session_id}"):
            # When a chat is selected from history:
            # 1. Store the selected session_id
            st.session_state.selected_session_id = session_id

            # 2. Update current_chat_session_id to the selected one
            st.session_state.current_chat_session_id = session_id

            # 3. Clear current messages to trigger reload in _initialize_chat_components
            if "messages" in st.session_state:
                del st.session_state["messages"]

            # 4. Rerun the app to reload the chat and update the runner
            st.rerun()

def main() -> None:
    """Main function to run the Streamlit AI Data Analyst application."""
    _setup_page()

    # --- Sidebar: Database Connection Management ---
    configs = config_manager.get_all_config_names()
    selected_name = _render_sidebar_connection_selector(configs)
    _render_sidebar_connection_crud(selected_name, configs)

    # --- Chat History Display ---
    _render_sidebar_chat_history() # New function call

    # --- Load active config and set environment variables ---
    active_config = _get_and_set_active_db_config(selected_name)

    # --- Display Active Connection's Schema and Data Context in Sidebar ---
    _display_sidebar_active_config_info(active_config)

    # --- Main Content: AI Chat Interface ---
    _initialize_chat_components()
    _display_chat_history()

    prompt = st.chat_input("What would you like to know?")
    if prompt:
        _process_user_prompt(prompt, active_config)

if __name__ == "__main__":
    main()
