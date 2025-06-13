import streamlit as st
import json
import asyncio
import os
import pandas as pd
import altair as alt

from enem_ai_analyst.agent import root_agent
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.genai import types

APP_NAME = "google_search_agent"
USER_ID = "user1234"
SESSION_ID = "1234"

# Session and Runner
session_service = InMemorySessionService()
asyncio.run(session_service.create_session(app_name=APP_NAME, user_id=USER_ID, session_id=SESSION_ID))
runner = Runner(agent=root_agent, app_name=APP_NAME, session_service=session_service)

st.set_page_config(page_title="ENEM AI Analyst", layout="wide")

st.title("🤖 ENEM AI Analyst")
st.caption("Ask me anything about the ENEM data!")


def parse_and_display_content(content_text):
    """Parse content and display text, tables, and charts"""

    # Split content by common delimiters that might separate text from chart specs
    parts = []

    # Look for chart specifications (JSON blocks)
    lines = content_text.split('\n')
    current_text = []
    in_json_block = False
    json_block = []

    for line in lines:
        stripped_line = line.strip()

        # Check if this line starts a JSON block
        if stripped_line.startswith('```') and 'json' in stripped_line.lower():
            if current_text:
                parts.append(('text', '\n'.join(current_text)))
                current_text = []
            in_json_block = True
            continue
        elif stripped_line == '```' and in_json_block:
            if json_block:
                parts.append(('json', '\n'.join(json_block)))
                json_block = []
            in_json_block = False
            continue

        if in_json_block:
            json_block.append(line)
        else:
            current_text.append(line)

    # After the loop, flush any remaining content
    if in_json_block: # Loop ended inside a JSON block
        if json_block:
            parts.append(('text', '\n'.join(json_block))) # Treat unterminated JSON as text
    elif current_text: # Loop ended outside a JSON block, and there's pending text
        parts.append(('text', '\n'.join(current_text)))

    # If no parts were found, treat entire content as text
    if not parts and content_text.strip(): # Check if content_text had actual content
        parts = [('text', content_text)]

    # Display each part
    for part_type, part_content in parts:
        if part_type == 'text' and part_content.strip():
            st.markdown(part_content.strip())
        elif part_type == 'json':
            try:
                chart_spec = json.loads(part_content)

                chart = alt.Chart(pd.DataFrame(chart_spec["data"]["values"]))

                if chart_spec["mark"] == "bar":
                    chart = chart.mark_bar()
                chart = chart.encode(
                    alt.X(chart_spec["encoding"]["x"]["field"], 
                          type=chart_spec["encoding"]["x"]["type"],
                          title=chart_spec["encoding"]["x"]["title"]),
                    alt.Y(chart_spec["encoding"]["y"]["field"], 
                          type=chart_spec["encoding"]["y"]["type"],
                          sort=chart_spec["encoding"]["y"]["sort"],
                          title=chart_spec["encoding"]["y"]["title"])
                )
                chart = chart.properties(title=chart_spec["title"])
                st.altair_chart(chart, use_container_width=True)

            except json.JSONDecodeError:
                st.error("Failed to parse chart specification")
                st.code(part_content, language='json')
            except Exception as e:
                st.error(f"Failed to render chart: {e}")
                st.code(part_content, language='json')


def display_message_content(message):
    """Display a message based on its type"""
    print("MYDEBUG: display_message_content")
    if message["type"] == "chart":
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
    elif message["type"] == "mixed":
        # Handle mixed content (text + charts + tables)
        parse_and_display_content(message["content"])
    else:
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

                    # Check if response contains both text and chart data
                    has_chart_marker = 'Chart:' in full_response_content or 'Gráfico:' in full_response_content
                    has_json_block = '```' in full_response_content and (
                                '{' in full_response_content or '[' in full_response_content)

                    # Determine content type
                    if has_chart_marker or has_json_block:
                        print("MYDEBUG: has_chart_marker=true or has_json_block=true")

                        # Mixed content - contains text and possibly charts
                        parse_and_display_content(full_response_content)
                        st.session_state.messages.append(
                            {"role": "assistant", "content": full_response_content, "type": "mixed"})
                    elif full_response_content.strip().startswith("{") and full_response_content.strip().endswith("}"):
                        # Pure JSON chart specification
                        print("MYDEBUG: Pure JSON chart specification")
                        try:
                            chart_spec = json.loads(full_response_content)
                            if "$schema" in chart_spec or ("mark" in chart_spec and "encoding" in chart_spec):
                                st.altair_chart(chart_spec, use_container_width=True)
                                st.session_state.messages.append(
                                    {"role": "assistant", "content": full_response_content, "type": "chart"})
                            else:
                                st.markdown(full_response_content)
                                st.session_state.messages.append(
                                    {"role": "assistant", "content": full_response_content, "type": "text"})
                        except json.JSONDecodeError:
                            st.markdown(full_response_content)
                            st.session_state.messages.append(
                                {"role": "assistant", "content": full_response_content, "type": "text"})
                    elif full_response_content.strip().startswith("[") and full_response_content.strip().endswith("]"):
                        # JSON array - potentially table data
                        print("MYDEBUG: JSON array - potentially table data")
                        try:
                            data = json.loads(full_response_content)
                            if isinstance(data, list) and all(isinstance(item, dict) for item in data):
                                chart_keywords = ["chart", "graph", "plot", "visualize", "visualization", "diagram"]
                                is_chart_request = any(keyword in prompt.lower() for keyword in chart_keywords)

                                df = pd.DataFrame(data)

                                if is_chart_request and len(df.columns) >= 2:
                                    # Display as chart
                                    x_column = df.columns[0]
                                    numeric_cols = [col for col in df.columns if pd.api.types.is_numeric_dtype(df[col])]
                                    y_column = numeric_cols[0] if numeric_cols else df.columns[1]

                                    chart = alt.Chart(df).mark_bar().encode(
                                        x=alt.X(x_column),
                                        y=alt.Y(y_column),
                                        tooltip=list(df.columns)
                                    ).properties(
                                        title=f"{y_column} by {x_column}"
                                    )

                                    st.altair_chart(chart, use_container_width=True)
                                    chart_spec = chart.to_dict()
                                    st.session_state.messages.append(
                                        {"role": "assistant", "content": json.dumps(chart_spec), "type": "chart"})
                                else:
                                    # Display as table
                                    st.table(df)
                                    st.session_state.messages.append(
                                        {"role": "assistant", "content": full_response_content, "type": "table"})
                            else:
                                st.markdown(full_response_content)
                                st.session_state.messages.append(
                                    {"role": "assistant", "content": full_response_content, "type": "text"})
                        except json.JSONDecodeError:
                            st.markdown(full_response_content)
                            st.session_state.messages.append(
                                {"role": "assistant", "content": full_response_content, "type": "text"})
                    else:
                        # Regular text content
                        st.markdown(full_response_content)
                        st.session_state.messages.append(
                            {"role": "assistant", "content": full_response_content, "type": "text"})
                else:
                    error_message = "No response received from the agent."
                    st.error(error_message)
                    st.session_state.messages.append({"role": "assistant", "content": error_message, "type": "text"})

            except Exception as e:
                error_message = f"An error occurred: {e}"
                message_placeholder.error(error_message)
                st.session_state.messages.append({"role": "assistant", "content": error_message, "type": "text"})