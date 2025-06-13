import json
import logging
from typing import Dict, Optional

import altair as alt
import pandas as pd
from google.adk.agents import LlmAgent
from pydantic import BaseModel, Field

from enem_ai_analyst.tools.chart_validation import validate_chart_spec

# Configure logging for the visualization agent
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)
logger.info("Visualization Agent module loaded.")

class VisualizationAgentOutput(BaseModel):
    """Structured output for the Visualization Agent."""
    chart_spec: Optional[str] = Field(None, description="The JSON string representation of the Altair chart specification. This will be null if an error occurs.")
    error_message: Optional[str] = Field(None, description="An error message if chart generation failed. This will be null if successful.")
    status: str = Field(..., description="Indicates the outcome of the chart generation. Must be 'success' or 'error'.")


def generate_chart(
        chart_type: str,
        chart_spec: str,
) -> str:
    """
    Generates an Altair chart specification based on the provided chart specification.
    This tool receives a complete Vega-Lite chart specification and validates it.

    Args:
        chart_type: The type of chart (e.g., 'altair', 'bar', 'line', etc.)
        chart_spec: A JSON string containing the complete Vega-Lite chart specification

    Returns:
        The validated chart specification as a JSON string, or an error message
    """
    logger.debug(
        f"generate_chart called with chart_type: {chart_type}, chart_spec length: {len(chart_spec) if chart_spec else 0}")

    if not chart_spec:
        logger.error("No chart specification provided.")
        return "Error: No chart specification provided."

    try:
        # Parse the chart specification
        if isinstance(chart_spec, str):
            chart_data = json.loads(chart_spec)
        else:
            chart_data = chart_spec

        logger.debug("Successfully parsed chart specification.")

        # Validate the chart specification
        is_valid, error_message = validate_chart_spec(chart_data)
        if not is_valid:
            logger.error(f"Chart validation failed: {error_message}")
            return f"Error: Invalid chart specification: {error_message}"

        logger.info("Chart specification validated successfully.")
        return json.dumps(chart_data)

    except json.JSONDecodeError as e:
        logger.error(f"Invalid JSON in chart specification: {str(e)}")
        return f"Error: Invalid JSON in chart specification: {str(e)}"
    except Exception as e:
        logger.error(f"Error during chart processing: {str(e)}", exc_info=True)
        return f"Error: An exception occurred during chart processing: {str(e)}"


VISUALIZATION_AGENT_INSTRUCTION = """
You are the **Visualization Agent** for ENEM-AI Analyst, specializing in creating **interactive data visualizations** to present educational insights. Your role is crucial in translating complex data into clear, understandable, and actionable visual formats for users.

**Input**: You will receive analyzed data (typically in a tabular format) and instructions from the Orchestrator Agent regarding the user's original query and the desired type of visualization.

**Task**: Your primary task is to **generate a Vega-Lite/Altair chart specification** that visually represents the provided data.

**Key Responsibilities**:
1.  **Analyze Data and Context**: Understand the structure of the input data and the analytical goal from the Orchestrator Agent.
2.  **Select Appropriate Chart Type**: Based on the data and query intent, **choose the most suitable visualization**:
    *   **Bar Chart**: Use for comparing distinct categories (e.g., average scores by state).
    *   **Line Chart**: Use for showing trends over time (e.g., performance evolution over multiple years).
    *   **Scatter Plot**: Use for illustrating relationships or correlations between two numerical variables.
    *   **Table**: Use for presenting raw data or aggregated results when a graphical representation is less suitable or for supplementary detail.
3.  **Data Transformation (if necessary)**: If the input data is in a 'wide-form' format, use Altair's `transform_fold` or similar methods to convert it to 'long-form' as Altair prefers this structure for encoding.
4.  **Encoding**: Correctly map data fields to visual encoding channels (e.g., X, Y, Color, Size). Explicitly specify data types (e.g., `:N` for nominal, `:Q` for quantitative, `:T` for temporal) when Altair cannot infer them (e.g., if data is not a Pandas DataFrame).
5.  **Generate Altair Spec**: Produce a complete and syntactically correct Altair chart object (which will be converted to Vega-Lite JSON by the system for rendering). Ensure the chart is interactive where appropriate.

**Output**: Provide the Altair chart object, which will be integrated into the final response to the user.
"""
# Create the agent instance
visualization_agent = LlmAgent(
    name="visualization_agent",
    model="gemini-2.5-flash-preview-05-20",
    instruction=VISUALIZATION_AGENT_INSTRUCTION,
    description="Generates specifications for data visualizations by calling the `generate_chart` tool based on provided datasets and user requests.",
    tools=[generate_chart], # Provide the agent with the tool it can use
)
logger.info("Visualization Agent initialized.")
