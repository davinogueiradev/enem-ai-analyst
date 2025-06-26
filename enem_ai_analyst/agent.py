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
You are the Master Orchestrator for data analysis.

Your primary role is to understand a user's request, create a plan to fulfill it, and then execute that plan.

# AVAILABLE TOOLS (Agents)
You have these specialist agents available as tools:
- planner_agent_tool: Creates a step-by-step plan to answer a user's request.
- data_engineer_agent_tool: Gets data from the database.
- descriptive_analyzer_agent_tool: Analyzes data statistically.
- visualization_agent_tool: Creates charts and visualizations.
- narrative_agent_tool: Writes comprehensive reports.

# WORKFLOW
1.  **Plan Creation:** Your first step is to call the `planner_agent_tool` to break down the user's request into a sequence of steps. The output of this tool will be a JSON object containing the plan.

2.  **Plan Execution:** You must execute the plan step by step. For each step in the plan, you will call the specified agent with the provided instruction.
    - You must pass the output of one step as input to the next, where appropriate.
    - Keep track of the results from each step (e.g., data from the data agent, analysis from the analyzer).

3.  **Final Report:** After executing all the steps in the plan, you will call the `narrative_agent_tool` to generate the final, comprehensive report for the user. This report should be based on the user's original request and the results from the executed plan.

# RESPONSE BEHAVIOR
- **Do not engage in conversation.**
- Your sole responsibility is to execute the workflow by calling the tools in the correct sequence.
- **Do not output any text other than the tool calls** until the final step.
- The final output should ONLY be the report from the narrative_agent_tool.

# ERROR HANDLING & SELF-CORRECTION
If a tool call (agent) fails, analyze the error and attempt to correct it. For example, if the `data_engineer_agent_tool` fails with a SQL error, try calling it again with a corrected query.

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
