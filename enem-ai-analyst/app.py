from dotenv import load_dotenv
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from agents import root_agent # This imports data_agent via agents/__init__.py

# Load environment variables from a .env file if it exists.
# This is useful for API keys or other configurations.
load_dotenv()

# Create an instance of the ADK Runner.
# The 'adk web' command will look for this instance (conventionally named 'app' or 'runner').
# InMemorySessionService is suitable for local development and exploration.
app = Runner(
    session_service=InMemorySessionService()
)

# Register your root_agent with the runner.
# 'is_root=True' tells the ADK that this is the primary agent to interact with
# when you open the web interface.
app.register_agent(agent=root_agent, is_root=True)

# The 'if __name__ == "__main__":' block is typically used for code
# that should run when the script is executed directly (e.g., python app.py).
# For 'adk web', the command itself handles starting the server, so this
# block isn't strictly necessary for that purpose but can be useful for
# providing information or alternative ways to run the app.
if __name__ == "__main__":
    print("ADK application configured in app.py.")
    print("This app.py defines a Runner and registers 'root_agent'.")
    print("You can run this application using a generic ASGI server, for example:")
    print("  uvicorn enem_ai_analyst.app:app --reload")
    print("\nAlternatively, to use the 'adk web AGENTS_DIR' command:")
    print("1. Ensure you have an agents directory (e.g., './adk_server_agents').")
    print("2. Inside it, each agent should be in a subdirectory with an '__init__.py' and an 'agent.py' (defining an 'agent' instance).")
    print("3. Run: adk web ./adk_server_agents")
    # If you wanted to start the server programmatically from this script, you would add:
    # import asyncio
    # async def start():
    #     await app.run_web_server()
    # asyncio.run(start())