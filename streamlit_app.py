import asyncio
import json
import re
import os

import pandas as pd
import streamlit as st
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.genai import types

from enem_ai_analyst.agent import root_agent
from enem_ai_analyst.tools.postgres_mcp import list_tables_and_schemas

APP_NAME = "ai_data_analyst_app"
USER_ID = "user12345"
SESSION_ID = "session12345"

def display_message_content(message_text):
    """Display message content, rendering text and charts in order."""
    # Regex to find vega-lite or json code blocks and the text around them
    pattern = r'(.*?)(```(?:json)\n(.*?)\n```)'

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
            chart_data = json.loads(chart_json_str.strip())
            chart_spec = chart_data.get("chart_spec", {})
            filterable_columns = chart_data.get("filterable_columns", [])

            if not chart_spec:
                st.error("Chart specification is missing.")
                continue

            data = pd.DataFrame(chart_spec.get("data", {}).get("values", []))

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
                
                st.vega_lite_chart(filtered_data, chart_spec, use_container_width=True)
            elif not data.empty:
                st.vega_lite_chart(data, chart_spec, use_container_width=True)

        except json.JSONDecodeError as e:
            st.error(f"Failed to parse chart JSON: {e}")
            st.code(chart_json_str, language="json")
        except Exception as e:
            st.error(f"Failed to render chart {i+1}: {e}")
            st.json(chart_data)
        
        # Update the position of the last match
        last_end = message_text.find(full_chart_block, last_end) + len(full_chart_block)

    # Display any remaining text after the last chart
    remaining_text = message_text[last_end:].strip()
    if remaining_text:
        st.markdown(remaining_text)

def main() -> None:
    st.set_page_config(page_title="AI Data Analyst", layout="wide")

    st.sidebar.title("Database Configuration")
    st.sidebar.caption("Connect to your PostgreSQL database")

    db_host = st.sidebar.text_input("Host", os.environ.get("POSTGRES_HOST", "localhost"))
    db_port = st.sidebar.text_input("Port", os.environ.get("POSTGRES_PORT", "5432"))
    db_name = st.sidebar.text_input("Database", os.environ.get("POSTGRES_DB", "enem_data"))
    db_user = st.sidebar.text_input("Username", os.environ.get("POSTGRES_USER", "user"))
    db_password = st.sidebar.text_input("Password", os.environ.get("POSTGRES_PASSWORD", "password"), type="password")

    os.environ["POSTGRES_HOST"] = db_host
    os.environ["POSTGRES_PORT"] = db_port
    os.environ["POSTGRES_DB"] = db_name
    os.environ["POSTGRES_USER"] = db_user
    os.environ["POSTGRES_PASSWORD"] = db_password

    if st.sidebar.button("Load Schema"):
        with st.spinner("Loading schema..."):
            st.session_state.db_schema = list_tables_and_schemas()
    
    if "db_schema" in st.session_state:
        st.sidebar.markdown("**Database Schema:**")
        st.sidebar.code(st.session_state.db_schema)

    st.sidebar.title("Data Context")
    st.sidebar.caption("Provide additional information about your data and tables.")
    st.session_state.data_context = st.sidebar.text_area(
        "Data Context",
        st.session_state.get("data_context", ""),
        help="Provide details about the data, tables, and columns to help the AI understand the context."
    )

    st.title("🤖 AI Data Analyst")
    st.caption("Ask me anything about your data!")

    # Initialize session state for messages and runner
    if "messages" not in st.session_state:
        st.session_state["messages"] = []
    if "runner" not in st.session_state:
        session_service = InMemorySessionService()
        # Create session only once
        asyncio.run(session_service.create_session(app_name=APP_NAME, user_id=USER_ID, session_id=SESSION_ID))
        st.session_state["runner"] = Runner(agent=root_agent, app_name=APP_NAME, session_service=session_service)

    runner = st.session_state["runner"]

    # displying chat history messages
    for message in st.session_state["messages"]:
        with st.chat_message(message["role"]):
            display_message_content(message["content"])

    prompt = st.chat_input("What would you like to know?")
    if prompt:
        # Add user message to history and display it
        st.session_state["messages"].append({"role": "user", "content": prompt})
        with st.chat_message("user"):
            st.markdown(prompt)

        # Get and display assistant response
        with st.chat_message("assistant"):
            with st.spinner("Thinking..."):
                if "db_schema" not in st.session_state:
                    st.error("Please load the database schema first.")
                else:
                    prompt_with_context = f"""
Database Schema: {st.session_state.db_schema}

Data Context:
{st.session_state.data_context}

User Request: {prompt}
"""
                    content = types.Content(role="user", parts=[types.Part(text=prompt_with_context)])
                    events = runner.run(user_id=USER_ID, session_id=SESSION_ID, new_message=content)

                    full_response = ""
                    for event in events:
                        if event.is_final_response() and event.content:
                            for part in event.content.parts:
                                full_response += part.text
                    
                    if full_response:
                        display_message_content(full_response)
                        st.session_state["messages"].append({"role": "assistant", "content": full_response})
                    else:
                        st.error("Sorry, I couldn't generate a response.")

if __name__ == "__main__":
    main()
