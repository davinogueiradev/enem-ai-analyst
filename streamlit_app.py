import streamlit as st
import json
import asyncio
import os

from enem_ai_analyst.agent import root_agent
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.genai import types

APP_NAME="google_search_agent"
USER_ID="user1234"
SESSION_ID="1234"

# Session and Runner
session_service = InMemorySessionService()
# The create_session method is a coroutine and needs to be run in an event loop.
# asyncio.run() will execute the coroutine, ensuring the session is created
# and registered within the InMemorySessionService.
# The variable 'session' was not used, so we don't need to assign the result.
asyncio.run(session_service.create_session(app_name=APP_NAME, user_id=USER_ID, session_id=SESSION_ID))
runner = Runner(agent=root_agent, app_name=APP_NAME, session_service=session_service)

st.set_page_config(page_title="ENEM AI Analyst", layout="wide")

st.title("🤖 ENEM AI Analyst")
st.caption("Ask me anything about the ENEM data!")

# Initialize chat history
if "messages" not in st.session_state:
    st.session_state.messages = []

# Display chat messages from history on app rerun
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        if message["type"] == "chart":
            try:
                chart_spec = json.loads(message["content"])
                st.altair_chart(chart_spec, use_container_width=True)
            except json.JSONDecodeError:
                st.error("Failed to parse chart specification.")
                st.markdown(message["content"]) # Fallback to markdown
            except Exception as e:
                st.error(f"Failed to render chart: {e}")
                st.markdown(message["content"]) # Fallback to markdown
        else:
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
                # Send the prompt to the agent
                # The agent expects a dictionary with an "input" key

                content = types.Content(role="user", parts=[types.Part(text=prompt)])

                events = runner.run(user_id=USER_ID, session_id=SESSION_ID, new_message=content)

                for event in events:
                    if event.is_final_response():
                        print(f"DEBUG: Final response received. {event.content.parts}")
                        # The agent's response text is in the first part of the content.
                        # If event.content.parts is empty or the first part is not text,
                        # this would need more robust error handling.
                        # For typical text responses, this is standard.
                        full_response_content = event.content.parts[0].text if event.content.parts else ""

                        # Check if the response is a chart specification (JSON string)
                        is_chart = False
                        if isinstance(full_response_content, str) and \
                        full_response_content.strip().startswith("{") and \
                        full_response_content.strip().endswith("}"):
                            try:
                                chart_spec = json.loads(full_response_content)
                                # A simple check for Altair specs (they usually have $schema)
                                if "$schema" in chart_spec or ("mark" in chart_spec and "encoding" in chart_spec):
                                    st.altair_chart(chart_spec, use_container_width=True)
                                    is_chart = True
                                    st.session_state.messages.append({"role": "assistant", "content": full_response_content, "type": "chart"})
                            except json.JSONDecodeError:
                                # Not a valid JSON, treat as text
                                pass
                            except Exception:
                                # Error rendering chart, treat as text
                                pass

                        if not is_chart:
                            message_placeholder.markdown(full_response_content)
                            st.session_state.messages.append({"role": "assistant", "content": full_response_content, "type": "text"})

            except Exception as e:
                error_message = f"An error occurred: {e}"
                message_placeholder.error(error_message)
                st.session_state.messages.append({"role": "assistant", "content": error_message, "type": "text"})