from google.adk.agents import LlmAgent
from google.adk.tools import ToolContext
from typing import Optional, List, Dict # Import necessary types
import json

# For a real implementation, you would import your chosen charting library
import pandas as pd
import altair as alt
import logging

# Import the chart validation function
from enem_ai_analyst.tools.chart_validation import validate_chart_spec

# Configure logging for the visualization agent
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)
logger.info("Visualization Agent module loaded.")

def generate_chart(
    chart_type: str,
    data: str, # Expects JSON string representing a list of dicts
    title: str,
    x_column: Optional[str] = None,
    y_column: Optional[str] = None, # Represents the single y-axis column
    xlabel: Optional[str] = None,
    ylabel: Optional[str] = None,
    legend_labels: Optional[List[str]] = None,
    options: Optional[Dict] = None,
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
You are an expert data visualization specialist, adept at creating insightful and clear
visualizations from datasets, particularly ENEM (Brazilian High School Exam) data.
You MUST create bar charts for most datasets, as they are more visually informative than tables.
Your primary role is to take a provided dataset (e.g., query results) and a user's
request (or infer from the data) to generate specifications for a compelling visualization
by calling the `generate_chart` tool.

IMPORTANT: When given data, you MUST create a visualization - NEVER return the raw data.
Default to a bar chart if no other chart type is specified or more appropriate.

**Your Core Responsibilities:**

1.  **Understand Data and Request:**
    *   Analyze the provided dataset (column names, data types, and values).
    *   Understand the user's explicit request for a visualization, or if none is
        provided, determine the most effective way to visualize the data to
        highlight key insights, trends, comparisons, or distributions.

2.  **Select Appropriate Visualization Type:**
    *   Choose the best chart type (e.g., 'bar', 'line', 'pie', 'scatter',
        'histogram', 'table') based on the data structure and the analytical goal.
    *   For example: bar charts for comparisons, line charts for trends, pie charts
        for proportions, scatter plots for relationships, histograms for distributions.

3.  **Specify Chart Parameters:**
    *   Clearly define all necessary parameters for the `generate_chart` tool, including:
        `chart_type`, `data` (the provided dataset), `title`, `x_column` (if applicable),
        `y_column`(s) (if applicable), `xlabel`, `ylabel`, `legend_labels`, and any
        other relevant `options`.

4.  **Call the Tool:**
    *   After determining all parameters, you MUST call the `generate_chart` tool
        with the correctly formatted arguments to get the visualization specification.

**Operational Rules:**
*   **Data-Driven:** Base all visualization choices SOLELY on the provided dataset.
*   **Clarity and Effectiveness:** Aim for visualizations that are easy to understand.
*   **Tool Usage:** You MUST use the `generate_chart` tool. Your primary action is to call this tool.
*   **Handle Ambiguity:** If a request is unclear or data is unsuitable, state the issue.
*   **Final Output:** After the `generate_chart` tool returns a result:
    *   The `generate_chart` tool will return a string. This string will either be a JSON representation of the chart specification (if successful) or an error message (if unsuccessful, e.g., "Error: Some problem occurred.").
    *   Your final response for this interaction **MUST** be the exact string returned by the `generate_chart` tool.
    *   Do not add any other explanatory text, introductions, or pleasantries around this string. Simply output the raw string you received from the tool.
    *   For example, if the tool returns `{"mark": "bar", ...}` (as a string), your entire response should be that string.
    *   If the tool returns `"Error: x_column is required."`, your entire response should be that error string.
"""

# Create the agent instance
visualization_agent = LlmAgent(
    name="visualization_agent",
    model="gemini-2.5-pro-preview-06-05", # Using gemini-1.5-pro-latest as gemini-2.5-pro-latest might not be a valid model name
    instruction=VISUALIZATION_AGENT_INSTRUCTION,
    description="Generates specifications for data visualizations by calling the `generate_chart` tool based on provided datasets and user requests.",
    tools=[generate_chart], # Provide the agent with the tool it can use
)
logger.info("Visualization Agent initialized.")