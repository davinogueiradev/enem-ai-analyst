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
    st.markdown(message["content"])


def display_structured_assistant_response(response_data):
    """Displays the content from a parsed structured JSON response from the assistant."""
    if "summary" in response_data and response_data["summary"]:
        st.markdown(message["content"])

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


# Initialize chat history
if "messages" not in st.session_state:
    st.session_state.messages = []

# Display chat messages from history on app rerun
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

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

                for event in events:
                    if event.is_final_response():
                        for part in event.content.parts:
                            st.markdown(part.text)

            except Exception as e:
                error_message = f"An error occurred: {e}"
                message_placeholder.error(error_message)
                st.session_state.messages.append({"role": "assistant", "content": error_message, "type": "text"})