import asyncio
import json

import pandas as pd
import streamlit as st
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.genai import types

from enem_ai_analyst.agent import root_agent

APP_NAME = "google_search_agent"
USER_ID = "user12345"
SESSION_ID = "12345"

# Session and Runner
session_service = InMemorySessionService()
asyncio.run(session_service.create_session(app_name=APP_NAME, user_id=USER_ID, session_id=SESSION_ID))
runner = Runner(agent=root_agent, app_name=APP_NAME, session_service=session_service)

st.set_page_config(page_title="ENEM AI Analyst", layout="wide")

st.title("🤖 ENEM AI Analyst")
st.caption("Ask me anything about the ENEM data!")

def display_message_content(message):
    """Display a message based on its type"""
    if message["role"] == "user":
        st.markdown(message["content"])
    elif message["role"] == "assistant":
        if message.get("type") == "structured_response":
            try:
                response_data = json.loads(message["content"])
                display_structured_assistant_response(response_data)
            except json.JSONDecodeError:
                st.error("Failed to parse assistant's structured response (JSON). Displaying raw content:")
                st.markdown(message["content"]) # Fallback to markdown
            except Exception as e:
                st.error(f"Error displaying structured assistant response: {e}")
                st.markdown(message["content"]) # Fallback
        elif message.get("type") == "text" or "type" not in message: # Fallback for simple text
            st.markdown(message["content"])
        else: # Handle other potential old types if necessary, or just markdown
            st.warning(f"Unknown assistant message type: {message.get('type')}. Displaying raw content.")
            st.markdown(message["content"])


def display_structured_assistant_response(response_data):
    """Displays the content from a parsed structured JSON response from the assistant."""
    if "summary" in response_data and response_data["summary"]:
        st.markdown(response_data["summary"])

    if "visualization" in response_data:
        viz = response_data["visualization"]
        viz_type = viz.get("type")

        if viz_type == "chart" and "spec" in viz:
            try:
                chart_spec = viz["spec"]
                st.altair_chart(chart_spec, use_container_width=True)
            except Exception as e:
                st.error(f"Failed to render chart from structured response: {e}")
                st.json(viz.get("spec", {})) # Show the spec if rendering fails
        elif viz_type == "table" and "data" in viz: # Assuming table data is in viz["data"]
            try:
                table_data = viz["data"]
                if isinstance(table_data, list):
                    df = pd.DataFrame(table_data)
                    st.table(df)
                else:
                    st.warning("Table data is not in the expected list format.")
                    st.json(table_data)
            except Exception as e:
                st.error(f"Failed to render table from structured response: {e}")
                st.json(viz.get("data", {}))
        elif viz_type and viz_type not in ["chart", "table", "text_only", "none"]:
             st.warning(f"Unsupported visualization type: {viz_type}")

    if "debug_info" in response_data:
        debug = response_data["debug_info"]
        if debug.get("show_sql_button") and "sql_query" in debug:
            with st.expander("Show SQL Query"):
                st.code(debug["sql_query"], language="sql")


# The old display_message_content logic, preserved for reference if needed, but replaced by the above.
def _display_message_content_old(message):
    """Display a message based on its type (OLD IMPLEMENTATION)"""
    if message["type"] == "chart": # This was for direct chart JSON
        try:
            chart_spec = json.loads(message["content"])
            # Check if this is a VisualizationAgentOutput structure
            if isinstance(chart_spec, dict) and "chart_spec" in chart_spec and "status" in chart_spec and chart_spec[
                "status"] == "success":
                try:
                    actual_chart_spec = json.loads(chart_spec["chart_spec"])
                    st.altair_chart(actual_chart_spec, use_container_width=True)
                except (json.JSONDecodeError, TypeError):
                    st.error("Failed to parse nested chart specification.")
                    st.markdown(message["content"])
            else:
                st.altair_chart(chart_spec, use_container_width=True)
        except json.JSONDecodeError:
            st.error("Failed to parse chart specification.")
            st.markdown(message["content"])
        except Exception as e:
            st.error(f"Failed to render chart: {e}")
            st.markdown(message["content"])
    elif message["type"] == "table":
        try:
            data = json.loads(message["content"])
            df = pd.DataFrame(data)
            st.table(df)
        except json.JSONDecodeError:
            st.error("Failed to parse table data.")
            st.markdown(message["content"])
        except Exception as e:
            st.error(f"Failed to render table: {e}")
            st.markdown(message["content"])
    elif message["type"] == "text": # Default or simple text
        st.markdown(message["content"])

# Initialize chat history
if "messages" not in st.session_state:
    st.session_state.messages = []

# Display chat messages from history on app rerun
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        display_message_content(message)

# React to user input
if prompt := st.chat_input("What would you like to know?"):
    # Add user message to chat history
    st.session_state.messages.append({"role": "user", "content": prompt, "type": "text"})
    # Display user message in chat message container
    with st.chat_message("user"):
        st.markdown(prompt)

    # Display assistant response in chat message container
    with st.chat_message("assistant"):
        message_placeholder = st.empty()
        full_response_content = ""
        with st.spinner("Thinking..."):
            try:
                content = types.Content(role="user", parts=[types.Part(text=prompt)])
                events = runner.run(user_id=USER_ID, session_id=SESSION_ID, new_message=content)

                # Collect all parts of the response
                all_response_parts = []

                for event in events:
                    if event.is_final_response():

                        # Collect all parts of the response
                        for part in event.content.parts:
                            if hasattr(part, 'text') and part.text:
                                all_response_parts.append(part.text)

                        # Combine all parts
                        full_response_content = '\n'.join(all_response_parts) if all_response_parts else ""

                if full_response_content:
                    # Clear the placeholder and display the content
                    message_placeholder.empty()
                    try:
                        # Attempt to extract the main JSON object from the raw response string.
                        # This handles cases where the LLM might include extraneous text or markdown
                        # around the JSON object it's supposed to return.
                        json_start_index = full_response_content.find('{')
                        json_end_index = full_response_content.rfind('}')
                        if json_start_index != -1 and json_end_index != -1 and json_end_index > json_start_index:
                            full_response_content = full_response_content[json_start_index : json_end_index + 1]
                        print(f"MYDEBUG: full_response_content >>>> {full_response_content}")
                        # Agent is expected to return a single JSON object string
                        response_data = json.loads(full_response_content)
                        
                        # Display the structured response immediately
                        display_structured_assistant_response(response_data)
                        
                        # Store the raw JSON string for history
                        st.session_state.messages.append(
                            {"role": "assistant", "content": full_response_content, "type": "structured_response"}
                        )
                    except json.JSONDecodeError:
                        # This case should ideally not happen if the agent adheres to ORCHESTRATOR_INSTRUCTION
                        st.error("Assistant response was not in the expected JSON format. Displaying raw response:")
                        st.markdown(full_response_content)
                        st.session_state.messages.append(
                            {"role": "assistant", "content": full_response_content, "type": "text"})
                    except Exception as e:
                        # Catch-all for other errors while processing the (assumed) valid JSON
                        st.error(f"Error processing assistant's response: {e}")
                        st.markdown(full_response_content) # Display raw content as fallback
                        st.session_state.messages.append(
                            {"role": "assistant", "content": full_response_content, "type": "text"}
                        )
                else:
                    error_message = "No response received from the agent."
                    st.error(error_message)
                    st.session_state.messages.append({"role": "assistant", "content": error_message, "type": "text"})

            except Exception as e:
                error_message = f"An error occurred: {e}"
                message_placeholder.error(error_message)
                st.session_state.messages.append({"role": "assistant", "content": error_message, "type": "text"})