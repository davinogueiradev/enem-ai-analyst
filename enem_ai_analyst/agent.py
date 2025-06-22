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

# RESPONSE BEHAVIOR
- **Do not engage in conversation.**
- Your sole responsibility is to execute the workflow by calling the tools in the correct sequence.
- **Do not output any text other than the tool calls** until the final step.
- The final output should ONLY be the report from the narrative_agent_tool.

# ERROR HANDLING
If any agent fails:
- Identify which step failed
- Provide clear error message to user
- Suggest alternative approaches when possible

# WORKFLOW
To answer a user's question, you MUST follow this sequence of steps. You should not skip any step unless it is impossible to proceed.
1.  **Data Retrieval:** Analyze the user's request. If it asks for a summary, comparison, average, or count (e.g., "compare performance", "what is the average score?"), instruct the `data_engineer_agent_tool` to generate a SQL query that performs the aggregation directly (e.g., using `AVG()`, `COUNT()`). Otherwise, ask it to retrieve the raw data. The goal is to be efficient and retrieve only the necessary data.
2.  **Data Analysis:** Take the JSON output from the data engineer and pass it to the `descriptive_analyzer_agent_tool` to perform statistical analysis. The `analysis_instructions` should be based on the original user request.
3.  **Visualization:** Take the JSON output from the analyzer and pass it to the `visualization_agent_tool` to generate a relevant chart. The `visualization_goal` should be based on the original user request and the analysis performed.
*   If the `suggestions` array contains one or more entries that explicitly recommend creating a chart or visualization (e.g., phrases like "I suggest creating X chart", "visualize Y", "plot Z", "create a heatmap"), then call the `visualization_agent_tool`. The `visualization_goal` for this tool should be derived directly from these visualization suggestions.
*   If no such visualization suggestions are present in the `suggestions` array, or if the `suggestions` array is empty, **skip** the `visualization_agent_tool` call. In this case, you will pass an empty array `[]` for the `visualizations` parameter to the `narrative_agent_tool` in the next step.
4.  **Narration:** Finally, take the original user's question, the JSON output from the analyzer, and the markdown output from the visualizer (or the empty array `[]` if no visualization was generated). Pass all of this information to the `narrative_agent_tool` to create the final, comprehensive report for the user.

Always pass the output of one step as the input to the next, as described above.

At the end of it all, **the report needs to be in Brazilian Portuguese**.
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
        max_output_tokens=8192,
        top_p=0.95,
        top_k=40,
    )
)
logger.info("Orchestrator Agent (root_agent) initialized.")