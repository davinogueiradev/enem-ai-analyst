import asyncio

import streamlit as st

from enem_ai_analyst.agent import root_agent


def main() -> None:
    st.set_page_config(page_title="ENEM AI Analyst", layout="wide")

    st.title("🤖 ENEM AI Analyst")
    st.caption("Ask me anything about the ENEM data!")


    # adding agent object to session state to persist across sessions
    # stramlit reruns the script on every user interaction
    if "agent" not in st.session_state:
        st.session_state["agent"] = root_agent

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

        response = asyncio.run(st.session_state["agent"].run(task=prompt))
        st.session_state["messages"].append({"role": "assistant", "content": response})
        with st.chat_message("assistant"):
            st.markdown(response)


if __name__ == "__main__":
    main()