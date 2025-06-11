import json
import logging
from typing import Dict, Optional

import altair as alt
import pandas as pd
from google.adk.agents import LlmAgent
from google.adk.tools import ToolContext
from pydantic import BaseModel, Field

from enem_ai_analyst.tools.chart_validation import validate_chart_spec

# Configure logging for the visualization agent
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)
logger.info("Visualization Agent module loaded.")

class VisualizationAgentOutput(BaseModel):
    """Structured output for the Visualization Agent."""
    chart_spec: Optional[str] = Field(None, description="The JSON string representation of the Altair chart specification. This will be null if an error occurs.")
    error_message: Optional[str] = Field(None, description="An error message if chart generation failed. This will be null if successful.")
    status: str = Field(..., description="Indicates the outcome of the chart generation. Must be 'success' or 'error'.")


def generate_chart(
    chart_type: str,
    data: str, # Expects JSON string representing a list of dicts
    title: str,
    x_column: Optional[str] = None,
    y_column: Optional[str] = None, # Represents the single y-axis column
    xlabel: Optional[str] = None,
    ylabel: Optional[str] = None,
    question: Optional[str] = None,
    toolContext: Optional[ToolContext] = None,
) -> str:
    """
    Generates an Altair chart specification based on the provided parameters.
    This tool uses Altair to create a chart object, which can then be
    rendered by Streamlit using st.altair_chart().
    """
    # Default to bar chart if not specified or set to table
    if not chart_type or chart_type.lower() == 'table':
        chart_type = 'bar'
        logger.info("No chart type specified or 'table' requested - defaulting to 'bar' chart")
    logger.debug(f"generate_chart called with chart_type: {chart_type}, x_column: {x_column}, y_column: {y_column}, title: {title}")
    if not data:
        logger.error("No data provided for chart generation.")
        return "Error: No data provided for chart generation."

    # If data is a string, assume it's JSON and parse it
    if isinstance(data, str):
        try:
            logger.debug("Attempting to parse string data as JSON.")
            data = json.loads(data)
            logger.debug("Successfully parsed JSON data.")
        except json.JSONDecodeError as e:
            logger.error(f"Invalid JSON data provided: {str(e)}")
            return f"Error: Invalid JSON data provided: {str(e)}"

    df = pd.DataFrame(data)
    chart = None
    logger.debug(f"DataFrame created with shape: {df.shape}")
    try:
        if chart_type == 'bar':
            # Auto-select columns if not provided
            if not x_column or not y_column:
                logger.info("Attempting to auto-select columns for bar chart")
                if df.empty:
                    return "Error: DataFrame is empty, cannot create bar chart."

                columns = df.columns.tolist()
                if not x_column and len(columns) > 0:
                    # Choose first column as x-axis by default
                    x_column = columns[0]
                    logger.info(f"Auto-selected x_column: {x_column}")

                if not y_column and len(columns) > 1:
                    # Choose the first numeric column as y-axis
                    numeric_cols = [col for col in columns if pd.api.types.is_numeric_dtype(df[col])]
                    if numeric_cols and numeric_cols[0] != x_column:
                        y_column = numeric_cols[0]
                    else:
                        # If no other numeric column, use the second column
                        y_column = columns[1] if len(columns) > 1 else None
                    logger.info(f"Auto-selected y_column: {y_column}")

                # If still missing required columns, return error
                if not x_column or not y_column:
                    return "Error: Could not automatically determine appropriate x and y columns for bar chart. Please specify them manually."

            # Create the bar chart
            chart = alt.Chart(df).mark_bar().encode(
                x=alt.X(x_column, title=xlabel or x_column),
                y=alt.Y(y_column, title=ylabel or y_column),
                tooltip=[x_column, y_column]
            ).properties(
                title=title or f"{y_column} by {x_column}"
            )
            logger.info(f"Generated bar chart with x='{x_column}', y='{y_column}'.")
        elif chart_type == 'line':
            if not x_column or not y_column:
                return "Error: x_column and y_column are required for line chart."
            chart = alt.Chart(df).mark_line().encode(
                x=alt.X(x_column, title=xlabel or x_column),
                y=alt.Y(y_column, title=ylabel or y_column),
                tooltip=[x_column, y_column]
            ).properties(
                title=title
            )
            logger.info(f"Generated line chart with x='{x_column}', y='{y_column}'.")
        elif chart_type == 'pie':
            if not x_column or not y_column: # x_column for category, y_column for value
                return "Error: x_column (for categories) and y_column (for values) are required for pie chart."
            chart = alt.Chart(df).mark_arc().encode(
                theta=alt.Theta(field=y_column, type="quantitative", title=ylabel or y_column),
                color=alt.Color(field=x_column, type="nominal", title=xlabel or x_column),
                tooltip=[x_column, y_column]
            ).properties(
                title=title
            )
            logger.info(f"Generated pie chart with category='{x_column}', value='{y_column}'.")
        elif chart_type == 'scatter':
            if not x_column or not y_column:
                return "Error: x_column and y_column are required for scatter plot."
            chart = alt.Chart(df).mark_point().encode(
                x=alt.X(x_column, title=xlabel or x_column),
                y=alt.Y(y_column, title=ylabel or y_column),
                tooltip=[x_column, y_column]
            ).properties(
                title=title
            )
            logger.info(f"Generated scatter plot with x='{x_column}', y='{y_column}'.")
        elif chart_type == 'histogram':
            if not x_column:
                return "Error: x_column is required for histogram."
            # y_column is typically 'count()' for a histogram, so not taken as direct input for encoding data field
            chart = alt.Chart(df).mark_bar().encode(
                x=alt.X(x_column, bin=alt.Bin(maxbins=20), title=xlabel or x_column), # Apply binning
                y=alt.Y('count()', title=ylabel or 'Count'),
                tooltip=[alt.Tooltip(x_column, bin=alt.Bin(maxbins=20)), 'count()']
            ).properties(
                title=title
            )
            logger.info(f"Generated histogram for column='{x_column}'.")

        else:
            logger.warning(f"Unsupported chart_type: {chart_type}")
            return f"Error: Unsupported chart_type: {chart_type}. Supported types: 'bar', 'line', 'pie', 'scatter', 'histogram'."

        if chart:
            chart_json_spec = chart.to_dict()
            logger.info("Altair chart specification generated successfully.")
            logger.debug(f"Chart Spec (first 100 chars): {str(chart_json_spec)[:100]}")

            # Validate the chart specification before returning
            is_valid, error_message = validate_chart_spec(chart_json_spec)
            if not is_valid:
                logger.error(f"Chart validation failed: {error_message}")
                return f"Error: Invalid chart specification: {error_message}"

            return json.dumps(chart_json_spec) # Return JSON string directly
        else:
            logger.error("Chart object was None after generation logic.")
            return "Error: Chart could not be generated due to an unexpected issue."

    except Exception as e:
        logger.error(f"Error during chart generation: {str(e)}", exc_info=True)
        return f"Error: An exception occurred during chart generation: {str(e)}"


VISUALIZATION_AGENT_INSTRUCTION = """
You are an expert data visualization specialist. Your primary role is to take a
provided dataset (typically a JSON string from `data_agent`) and a user's request,
then use the `generate_chart` tool to create an Altair chart specification.
Your final output MUST be a JSON object conforming to the `VisualizationAgentOutput` schema.

**Your Core Responsibilities:**

1.  **Understand Data and Request:**
    *   Analyze the provided dataset (column names, data types, and values).
    *   Understand the user's explicit request for a visualization. If no specific
        chart type is requested, default to a 'bar' chart.

2.  **Determine Parameters for `generate_chart` Tool:**
    *   Based on the data and request, decide the optimal values for the
        `generate_chart` tool's parameters.

3.  **Call `generate_chart` Tool:**
    *   You MUST call the `generate_chart` tool with the parameters you've determined.

4.  **Process Tool Output and Formulate Final Response:**
    *   The `generate_chart` tool will return a string: either a JSON string
        representing the Altair chart specification, or an error message string
        (which typically starts with "Error:").
    *   If the tool returns an Altair spec (a JSON string), set `status` to "success",
        place the spec string into the `chart_spec` field, and set `error_message` to `null`.
    *   If the tool returns an error message string, set `status` to "error",
        place the error message into the `error_message` field, and set `chart_spec` to `null`.
    *   Your final response MUST be a single JSON object strictly conforming to the
        `VisualizationAgentOutput` Pydantic schema.

**`generate_chart` Tool Details:**
*   **Purpose:** Generates an Altair chart specification JSON string.
*   **Parameters you need to provide:**
    *   `chart_type` (str): Type of chart. Supported: 'bar', 'line', 'pie', 'scatter', 'histogram'. Default to 'bar' if not specified or if 'table' is requested.
    *   `data` (str): The JSON string representing the data (list of dictionaries). This is the data you receive as input.
    *   `title` (str): A descriptive title for the chart. Infer this from the user's request or the data itself.
    *   `x_column` (Optional[str]): The name of the column to use for the x-axis. Crucial for most chart types.
    *   `y_column` (Optional[str]): The name of the column to use for the y-axis. Crucial for most chart types.
    *   `xlabel` (Optional[str]): Custom label for the x-axis. If None, column name is used.
    *   `ylabel` (Optional[str]): Custom label for the y-axis. If None, column name is used.
    *   `question` (Optional[str]): The original user question that prompted the visualization. This can help you determine a good title, x/y columns, and labels.
*   **Guidance for choosing `x_column` and `y_column`:**
    *   For 'bar' charts: `x_column` is typically categorical, `y_column` is typically numerical.
    *   For 'line' charts: `x_column` is often time or a sequence, `y_column` is numerical.
    *   For 'pie' charts: `x_column` represents categories, `y_column` represents numerical values for slices.
    *   For 'scatter' plots: Both `x_column` and `y_column` are typically numerical.
    *   For 'histogram': Only `x_column` (numerical) is strictly needed for the data field; y-axis will be count.
    *   If the user specifies columns, use them. Otherwise, infer the best columns from the data and the question.

**Operational Rules:**
*   **Tool Usage is Mandatory:** You MUST use the `generate_chart` tool to create visualizations. Do NOT attempt to construct the Altair JSON specification string yourself.
*   **Focus on Visualization:** Your primary goal is to produce a chart. Avoid returning raw data.
*   **Default to Bar Chart:** If the user asks for a "table" or doesn't specify a chart type, default to `chart_type='bar'` when calling `generate_chart`.
*   **Output Structure:** Your entire response must be a single JSON object conforming to `VisualizationAgentOutput`. No extra text.

**Input Data Format:**
The input data will typically be provided to you as a JSON string representing a list of
dictionaries (e.g., `"[{\"columnA\": \"value1\", \"columnB\": 10}, ...]"`) . You will pass this string directly to the `data` parameter of the `generate_chart` tool.

**Supported Chart Types (for `chart_type` parameter of `generate_chart` tool):**
'bar', 'line', 'pie', 'scatter', 'histogram'.

**Example of a successful output:**
```json
{
  "chart_spec": "{\"$schema\": \"https://vega.github.io/schema/vega-lite/v5.json\", \"data\": {\"values\": [...]}, \"mark\": \"bar\", ...}",
  "error_message": null,
  "status": "success"
}
```

**`VisualizationAgentOutput` Schema:**
```json
{
  "chart_spec": "string (nullable, JSON chart spec if successful)",
  "error_message": "string (nullable, error message if failed)",
  "status": "string ('success' or 'error')"
}
```
"""
# Create the agent instance
visualization_agent = LlmAgent(
    name="visualization_agent",
    model="gemini-2.5-pro-preview-06-05",
    instruction=VISUALIZATION_AGENT_INSTRUCTION,
    description="Generates specifications for data visualizations by calling the `generate_chart` tool based on provided datasets and user requests.",
    tools=[generate_chart], # Provide the agent with the tool it can use
)
logger.info("Visualization Agent initialized.")