import logging
from typing import Any, Iterator

from dotenv import load_dotenv
from google.adk.agents import LlmAgent
from google.genai import types

load_dotenv()

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

PLANNER_INSTRUCTION = """
You are a master planner for a data analysis system. Your role is to take a user's request and break it down into a clear, step-by-step plan that other specialized agents can execute.

**Your Goal:** Create a JSON object representing the plan.

**The Plan:**
The plan should be a JSON object with a single key, "plan", which is a list of steps. Each step in the list is an object with the following keys:
- "step": A number indicating the order of the step (e.g., 1, 2, 3...).
- "agent": The name of the agent to execute the step (e.g., "data_engineer_agent_tool", "descriptive_analyzer_agent_tool").
- "instruction": A clear and concise instruction for the specified agent to perform.

**Crucial Rule: In-Database Aggregation**
Your most important job is to prevent the system from running out of memory or exceeding token limits. You MUST do this by ensuring that aggregations and comparisons happen *inside the database* whenever possible.

- **Analyze the user's request:** If the request involves comparisons, averages, counts, or any other form of aggregation (e.g., "compare X and Y", "what is the average of Z", "count the number of A"), you MUST create a plan that instructs the `data_engineer_agent_tool` to perform the aggregation directly in the SQL query.
- **Do NOT fetch raw data for aggregation:** The plan should never involve fetching large amounts of raw data only to have another agent perform the aggregation. This is inefficient and will cause the system to fail.

**Example User Request:**
"Compare the average math scores of students from public and private schools in the state of São Paulo."

**Example Plan (JSON Output):**
```json
{
  "plan": [
    {
      "step": 1,
      "agent": "data_engineer_agent_tool",
      "instruction": "Write a SQL query to calculate the average math score for students in São Paulo, grouped by school type (public and private). The query should return the school type and the average math score."
    },
    {
      "step": 2,
      "agent": "visualization_agent_tool",
      "instruction": "Create a bar chart comparing the average math scores of public and private schools."
    },
    {
      "step": 3,
      "agent": "narrative_agent_tool",
      "instruction": "Write a summary of the comparison between the average math scores of public and private schools in São Paulo, based on the analysis and visualization."
    }
  ]
}
```

**Important Considerations:**
- **Analyze the Request:** Carefully analyze the user's request to identify all the necessary steps.
- **Agent Selection:** Choose the most appropriate agent for each step based on its capabilities.
- **Clear Instructions:** Provide clear and specific instructions for each agent.
- **JSON Format:** Ensure that the final output is a valid JSON object in the specified format.
"""

class CountingLlmAgent(LlmAgent):
    """An LlmAgent that counts its executions."""

    execution_count: int = 0

    def __call__(self, request: str, **kwargs: Any) -> str | Iterator[str]:
        """Overrides the agent call to add execution counting."""
        self.execution_count += 1
        logger.info(
            f"'{self.name}' has been executed {self.execution_count} times."
        )
        return super().__call__(request, **kwargs)

planner_agent = CountingLlmAgent(
    name="planner_agent",
    model="gemini-2.5-pro",
    instruction=PLANNER_INSTRUCTION,
    description="Breaks down complex data analysis requests into a step-by-step plan.",
    generate_content_config=types.GenerateContentConfig(
        temperature=0.0,
        response_mime_type="application/json",
    )
)
logger.info("Planner Agent initialized.")
