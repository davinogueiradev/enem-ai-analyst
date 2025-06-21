import asyncio
import json
import re

import pandas as pd
import streamlit as st
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.genai import types

from enem_ai_analyst.agent import root_agent

APP_NAME = "google_search_agent"
USER_ID = "user12345"
SESSION_ID = "12345"

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
    
    # Remove the vega-lite code blocks from the text and display the rest
    clean_text = re.sub(r'```vega-lite\n.*?\n```', '', message_text, flags=re.DOTALL)
    clean_text = re.sub(r'```json\n.*?\n```', '', clean_text, flags=re.DOTALL)
    clean_text = clean_text.strip()
    
    if clean_text:
        st.markdown(clean_text)

def main() -> None:
    # Session and Runner
    session_service = InMemorySessionService()
    asyncio.run(session_service.create_session(app_name=APP_NAME, user_id=USER_ID, session_id=SESSION_ID))
    runner = Runner(agent=root_agent, app_name=APP_NAME, session_service=session_service)

    st.set_page_config(page_title="ENEM AI Analyst", layout="wide")

    st.title("🤖 ENEM AI Analyst")
    st.caption("Ask me anything about the ENEM data!")

    # initialize chat history
    if "messages" not in st.session_state:
        st.session_state["messages"] = []

    # displying chat history messages
    for message in st.session_state["messages"]:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])

    prompt = st.chat_input("What would you like to know?")
    if prompt:
        st.session_state["messages"].append({"role": "user", "content": prompt})
        with st.chat_message("user"):
            st.markdown(prompt)

        content = types.Content(role="user", parts=[types.Part(text=prompt)])
        events = runner.run(user_id=USER_ID, session_id=SESSION_ID, new_message=content)

        for event in events:
            if event.is_final_response():
                print(F"MYDEBUG: parts {len(event.content.parts)}")
                for part in event.content.parts:
                    display_message_content(part.text)
                    st.session_state["messages"].append(
                        {"role": "assistant", "content": part.text, "type": "text"}
                    )

if __name__ == "__main__":
    main()