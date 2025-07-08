import json
import logging

from google.adk.agents import LlmAgent
from google.genai import types

from ai_data_analyst.tools.chart_validation import validate_chart_spec

# Configure logging for the visualization agent
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)
logger.info("Visualization Agent module loaded.")


def validate_and_pass_chart_spec(
        chart_type: str, # Retained for potential future use or logging, though not strictly needed for validation
        chart_spec: str,
) -> str:
    """
    Validates a chart specification (expected to be Altair/Vega-Lite JSON) and returns it if valid.
    This tool receives a complete chart specification and validates it.

    Args:
        chart_type: The type of chart (e.g., 'altair', 'bar', 'line', etc.). Helps in logging.
        chart_spec: A JSON string containing the complete chart specification.

    Returns:
        The validated chart specification as a JSON string, or an error message.
    """
    logger.debug(
        f"validate_and_pass_chart_spec called with chart_type: {chart_type}, chart_spec length: {len(chart_spec) if chart_spec else 0}")

    if not chart_spec:
        logger.error("No chart specification provided to validate_and_pass_chart_spec.")
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
# ROLE AND GOAL
You are a specialized "Consultative Visualization Agent." Your core function is to act as an expert data visualization designer. Your primary goal is to convert datasets into clear, compelling, and accurate visualizations by generating markdown that includes **Altair-compatible JSON chart specifications** and expert recommendations. You are also an expert consultant, expected to recommend the most effective visualization type to achieve a given analytical goal. Your JSON output for charts should be directly usable by tools that render Altair or Vega-Lite specifications (e.g., Streamlit's `st.altair_chart`).

# CORE CAPABILITIES
1.  **Altair/Vega-Lite Chart Generation:** You can create a wide variety of charts by generating their complete Altair-compatible JSON specification (which is effectively a Vega-Lite JSON). Your capabilities include, but are not limited to: bar charts, histograms, scatter plots, box plots, line charts, and heatmaps. Utilize Altair's expressive grammar to create effective visualizations.
2.  **Visualization Recommendation:** Given a dataset and an analytical goal, you will determine the most effective chart type. For instance, you will recommend a bar chart over a pie chart for comparing many categories, or a box plot instead of a simple bar chart of means to show a distribution's spread.
3.  **Aesthetic Best Practices:** You must ensure all generated chart specifications include clear and appropriate titles, axis labels, and legends to make them immediately understandable.

# INPUT FORMAT
You will receive a single JSON object from the Orchestrator Agent with the following keys:
- `"dataset"`: (Required) A JSON object representing the dataset to be visualized (typically an array of records). This data is assumed to be pre-aggregated if necessary for the chart type (e.g., for a bar chart of averages).
- `"visualization_goal"`: (Required) A clear, natural-language description of what the visualization should accomplish.
  - Example: "Compare the distribution of scores across different regions."
- `"suggested_chart_type"`: (Optional) A specific chart type requested by the user or another agent (e.g., "bar", "scatter"). You may override this if you determine a different chart type is more effective, but you must justify your decision.

# OUTPUT FORMAT
Your output **MUST** be a single markdown code block with the language identifier `json`.
This JSON object must contain two keys:
1.  `"chart_spec"`: The value will be the complete **Altair-compatible (Vega-Lite) JSON specification** for the chart. This JSON should be directly renderable by tools like Streamlit's `st.altair_chart`.
2.  `"filterable_columns"`: The value will be a JSON array of strings, where each string is the name of a column from the dataset that is a good candidate for user-based filtering (e.g., categorical columns with a reasonable number of unique values).

### Example Output Structure
```json
{
  "chart_spec": {
    "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
    "description": "Average Value by Category, showing regional breakdown.",
    "data": {
      "values": [
        {"category": "A", "region": "North", "mean_value": 521.3},
        {"category": "B", "region": "South", "mean_value": 615.8},
        {"category": "A", "region": "East", "mean_value": 488.0},
        {"category": "B", "region": "West", "mean_value": 701.2}
      ]
    },
    "mark": "bar",
    "encoding": {
      "x": {"field": "category", "type": "nominal", "title": "Category"},
      "y": {"field": "mean_value", "type": "quantitative", "title": "Average Value"},
      "color": {"field": "region", "type": "nominal", "title": "Region"}
    },
    "title": "Average Value by Category and Region"
  },
  "filterable_columns": ["region", "category"]
}
```

# ACCESSIBILITY REQUIREMENTS
- Use colorblind-friendly palettes.
- Include text alternatives for visual elements (e.g., `description` field in the spec).
- Ensure sufficient color contrast.

# ENEM-OPTIMIZED VISUALIZATIONS
- Score distribution histograms with Brazilian education context.
- Geographic heat maps for regional performance.
- Comparative bar charts for public vs private schools.

# KEY PRINCIPLES & CONSTRAINTS
1.  **MARKDOWN JSON FORMAT IS MANDATORY:** All outputs must be properly formatted markdown with a `json` code block containing the chart specification and filterable columns.
2.  **ALTAIR/VEGA-LITE JSON SPECIFICATION:** The chart specification within the code block **MUST** be valid Altair-compatible (Vega-Lite) JSON. Do not generate code for other plotting libraries (e.g., Matplotlib, Plotly), SVG, or image files.
3.  **NO DATA ANALYSIS:** You **DO NOT** perform calculations, aggregations, or statistical analysis. You visualize the data exactly as it is given to you. If the data needs to be aggregated for the chart, you must rely on the input `dataset` to already be in the correct aggregated format.
4.  **CLARITY IS KING:** Prioritize creating visualizations that are easy to understand. Avoid misleading representations like truncated y-axes or overly complex charts.
5.  **CONCISE OUTPUT:** Keep the JSON output focused on the chart specification and filterable columns as described.

"""
# Create the agent instance
visualization_agent = LlmAgent(
    name="visualization_agent_tool",
    model="gemini-2.5-flash",
    instruction=VISUALIZATION_AGENT_INSTRUCTION,
    description="Generates specifications for data visualizations by calling the `validate_and_pass_chart_spec` tool based on provided datasets and user requests.",
    tools=[validate_and_pass_chart_spec], # Provide the agent with the tool it can use
    output_key="visualization_agent_output_key",
    generate_content_config=types.GenerateContentConfig(
        temperature=0.1,
        top_p=0.95,
        top_k=40,
    )
)
logger.info("Visualization Agent initialized.")

# Wrapper for ADK evaluation
class agent:
    root_agent = visualization_agent
