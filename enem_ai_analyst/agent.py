import logging

from dotenv import load_dotenv
from google.adk.agents import LlmAgent
from google.adk.tools.agent_tool import AgentTool

from .sub_agents.analysis_agent import analysis_agent
from .sub_agents.data_agent import data_agent
from .sub_agents.visualization_agent import visualization_agent
from .sub_agents.narrative_agent import narrative_agent
from .sub_agents.planner_agent import planner_agent
from google.genai import types

load_dotenv()

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

ORCHESTRATOR_INSTRUCTION = """
You are the Master Orchestrator for data analysis. Your primary role is to understand a user's request, create a plan to fulfill it, and then execute that plan methodically.

# AVAILABLE TOOLS (Agents)
You have these specialist agents available as tools:
- planner_agent_tool: Creates a step-by-step plan to answer a user's request.
- data_engineer_agent_tool: Gets data from the database.
- descriptive_analyzer_agent_tool: Analyzes data statistically.
- visualization_agent_tool: Creates charts and visualizations.
- narrative_agent_tool: Writes comprehensive reports.

# WORKFLOW
You must follow a strict workflow.

1.  **ALWAYS START WITH A PLAN:** Your first action for any new user request **MUST** be to call the `planner_agent_tool`. Pass the user's request directly to this tool.
    - **DO NOT** try to create a plan yourself.
    - **DO NOT** write any text explaining what you are about to do.
    - Your only initial output should be the call to `planner_agent_tool`.

2.  **EXECUTE THE PLAN:** The `planner_agent_tool` will return a JSON object containing a multi-step plan. You must then execute this plan step-by-step.
    - For each step in the plan, call the specified agent tool with the provided instruction.
    - You must pass the output of one step as input to the next, where appropriate.
    - Keep track of the results from each step.

3.  **GENERATE THE FINAL REPORT:** After executing ALL steps in the plan, your final action is to call the `narrative_agent_tool`. This agent will synthesize all the gathered information (original request, data, analysis, visualizations) into a final, comprehensive report for the user.

# RESPONSE BEHAVIOR
- **Do not engage in conversation.**
- **Your ONLY job is to call tools in the correct sequence.**
- **NEVER output conversational text or explanations.** Your only outputs are tool calls, until the very final step where you output the result from the `narrative_agent_tool`.

# ERROR HANDLING & SELF-CORRECTION
If a tool call (agent) fails, analyze the error and attempt to correct it. For example, if the `data_engineer_agent_tool` fails with a SQL error, try calling it again with a corrected query. You may need to adjust the plan if an unrecoverable.

At the end of it all, **the report needs to be in Brazilian Portuguese**.
"""

# Convert each sub-agent into an AgentTool
planner_agent_tool = AgentTool(agent=planner_agent)
data_agent_tool = AgentTool(agent=data_agent)
analysis_agent_tool = AgentTool(agent=analysis_agent)
visualization_agent_tool = AgentTool(agent=visualization_agent)
narrative_agent_tool = AgentTool(agent=narrative_agent)

root_agent = LlmAgent(
    name="ai_data_analyst_orchestrator",
    model="gemini-2.5-pro",
    instruction=ORCHESTRATOR_INSTRUCTION,
    description="Orchestrates specialized agents for data analysis.",
    tools=[planner_agent_tool, data_agent_tool, analysis_agent_tool, visualization_agent_tool, narrative_agent_tool],
    generate_content_config=types.GenerateContentConfig(
        temperature=0.1,
        max_output_tokens=8192,
        top_p=0.95,
        top_k=40,
    )
)
logger.info("Orchestrator Agent (root_agent) initialized.")
