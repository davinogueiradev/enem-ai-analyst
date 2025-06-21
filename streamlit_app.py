import asyncio
import json
import re

import pandas as pd
import streamlit as st
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.genai import types

from enem_ai_analyst.agent import root_agent

APP_NAME = "enem_ai_analyst_app"
USER_ID = "user12345"
SESSION_ID = "session12345"

def extract_vega_lite_from_text(text):
    """Extract Vega-Lite JSON from markdown code blocks"""
    # Look for vega-lite code blocks
    vega_pattern = r'```vega-lite\n(.*?)\n```'
    matches = re.findall(vega_pattern, text, re.DOTALL)

    if not matches:
        json_pattern = r'```json\n(.*?)\n```'
        matches = re.findall(json_pattern, text, re.DOTALL)
    
    charts = []
    for match in matches:
        try:
            chart_spec = json.loads(match.strip())
            charts.append(chart_spec)
        except json.JSONDecodeError as e:
            st.error(f"Failed to parse Vega-Lite JSON: {e}")
    
    return charts


def display_message_content(message_text):
    """Display message content and extract/render any charts"""
    # First, extract and display any Vega-Lite charts
    # Remove the vega-lite code blocks from the text and display the rest
    clean_text = re.sub(r'```vega-lite\n.*?\n```', '', message_text, flags=re.DOTALL)
    clean_text = re.sub(r'```json\n.*?\n```', '', clean_text, flags=re.DOTALL)
    clean_text = clean_text.strip()
    
    if clean_text:
        st.markdown(clean_text)

    charts = extract_vega_lite_from_text(message_text)
    
    if charts:
        for i, chart in enumerate(charts):
            try:

                if chart.get("spec"):
                    chart = chart.pop("spec")

                chart_data = chart.pop("data", {})
                data = pd.DataFrame(chart_data["values"])
                chart_spec = chart

                st.vega_lite_chart(data, chart_spec, use_container_width=True)
            except Exception as e:
                st.error(f"Failed to render chart {i+1}: {e}")
                st.json(chart)

def main() -> None:
    st.set_page_config(page_title="ENEM AI Analyst", layout="wide")

    st.title("🤖 ENEM AI Analyst")
    st.caption("Ask me anything about the ENEM data!")

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
                content = types.Content(role="user", parts=[types.Part(text=prompt)])
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