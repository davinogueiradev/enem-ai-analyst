import streamlit as st
import os

# --- PAGE CONFIGURATION ---
# Set the page configuration. This must be the first Streamlit command.
st.set_page_config(
    page_title="ENEM-AI Analyst",
    page_icon="🧠",
    layout="wide",
)

# --- PAGE TITLE ---
st.title("🧠 ENEM-AI Analyst")
st.caption("Converse com os dados do ENEM e Censo Escolar em linguagem natural.")

# --- "HELLO WORLD" ---
# A simple placeholder to confirm the app is running.
st.write("Hello, World! The Streamlit application is running correctly.")

# --- EXAMPLE OF HOW TO READ ENVIRONMENT VARIABLES (from docker-compose.yml) ---
st.subheader("Database Connection Details (from environment variables):")
st.write(f"**Host:** {os.getenv('DB_HOST')}")
st.write(f"**Port:** {os.getenv('DB_PORT')}")
st.write(f"**Database Name:** {os.getenv('DB_NAME')}")
st.write(f"**User:** {os.getenv('DB_USER')}")

