import logging

from dotenv import load_dotenv
from google.adk.agents import LlmAgent
from google.adk.tools.agent_tool import AgentTool

from .sub_agents.analysis_agent import analysis_agent
from .sub_agents.data_agent import data_agent
from .sub_agents.visualization_agent import visualization_agent
from .sub_agents.narrative_agent import narrative_agent
from google.genai import types

load_dotenv()

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

ORCHESTRATOR_INSTRUCTION = """
You are the Master Orchestrator for ENEM data analysis.

# AVAILABLE TOOLS (Agents)
You have these specialist agents available as tools:
- data_engineer_agent_tool: Gets data from database
- descriptive_analyzer_agent_tool: Analyzes data statistically  
- visualization_agent_tool: Creates charts and visualizations
- narrative_agent_tool: Writes comprehensive reports

# ERROR HANDLING
If any agent fails:
- Identify which step failed
- Provide clear error message to user
- Suggest alternative approaches when possible

# WORKFLOW
Use these agent tools in sequence to answer user questions about ENEM data.
"""

# Convert each sub-agent into an AgentTool
data_agent_tool = AgentTool(agent=data_agent)
analysis_agent_tool = AgentTool(agent=analysis_agent)
visualization_agent_tool = AgentTool(agent=visualization_agent)
narrative_agent_tool = AgentTool(agent=narrative_agent)

root_agent = LlmAgent(
    name="enem_ai_analyst_orchestrator",
    model="gemini-2.5-pro-preview-06-05",
    instruction=ORCHESTRATOR_INSTRUCTION,
    description="Orchestrates specialized agents for ENEM data analysis.",
    tools=[data_agent_tool, analysis_agent_tool, visualization_agent_tool, narrative_agent_tool],
    generate_content_config=types.GenerateContentConfig(
        temperature=0.1,
        max_output_tokens=4096,
        top_p=0.95,
        top_k=40,
    )
)
logger.info("Orchestrator Agent (root_agent) initialized.")