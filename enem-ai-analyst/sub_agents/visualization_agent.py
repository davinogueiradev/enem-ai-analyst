from google.adk.agents import LlmAgent
from google.adk.tools import ToolContext

# For a real implementation, you would import your chosen charting library
import pandas as pd
import altair as alt


# --- Placeholder Tool ---
# This is a dummy implementation for the 'generate_chart' tool.
# In a real application, this tool would interface with a charting library
# (e.g., Matplotlib, Seaborn, Plotly) to generate actual visualizations
# or their specifications (e.g., Vega-Lite JSON).
def generate_chart(
    chart_type: str,
    data: list, # Expects list of dicts or similar structured data
    title: str,
    x_column: str = None,
    y_column: str | list[str] = None, # Can be a single column or list of columns for y-axis
    xlabel: str = None,
    ylabel: str = None,
    legend_labels: list[str] = None,
    options: dict = None,
    toolContext: ToolContext = None,
) -> dict:
    """
    Generates an Altair chart specification based on the provided parameters.
    This tool uses Altair to create a chart object, which can then be
    rendered by Streamlit using st.altair_chart().
    """
    if not data:
        return {"status": "error", "message": "No data provided for chart generation."}

    df = pd.DataFrame(data)
    chart = None

    try:
        if chart_type == 'bar':
            if not x_column or not y_column:
                return {"status": "error", "message": "x_column and y_column are required for bar chart."}
            chart = alt.Chart(df).mark_bar().encode(
                x=alt.X(x_column, title=xlabel or x_column),
                y=alt.Y(y_column, title=ylabel or y_column),
                tooltip=[x_column, y_column]
            ).properties(
                title=title
            )
        elif chart_type == 'line':
            if not x_column or not y_column:
                return {"status": "error", "message": "x_column and y_column are required for line chart."}
            chart = alt.Chart(df).mark_line().encode(
                x=alt.X(x_column, title=xlabel or x_column),
                y=alt.Y(y_column, title=ylabel or y_column),
                tooltip=[x_column, y_column]
            ).properties(
                title=title
            )
        # Add more chart types (pie, scatter, histogram etc.) here
        # For pie charts, you might need to transform data or use mark_arc
        # For scatter, use mark_point
        # For histogram, use mark_bar and binning

        else:
            return {"status": "error", "message": f"Unsupported chart_type: {chart_type}. Supported types: 'bar', 'line'."}

        if chart:
            # Altair chart objects can be converted to JSON dictionary
            chart_json_spec = chart.to_dict()
            return {
                "status": "success",
                "message": "Altair chart specification generated.",
                "chart_type": "altair", # Indicate the type of spec/object being returned
                "chart_spec": chart_json_spec # This is what Streamlit's st.altair_chart() can use
            }
        else:
            # This case should ideally be caught by specific chart type logic
            return {"status": "error", "message": "Chart could not be generated."}

    except Exception as e:
        return {"status": "error", "message": f"Error generating chart: {str(e)}"}


VISUALIZATION_AGENT_INSTRUCTION = """
You are an expert data visualization specialist, adept at creating insightful and clear
visualizations from datasets, particularly ENEM (Brazilian High School Exam) data.
Your primary role is to take a provided dataset (e.g., query results) and a user's
request (or infer from the data) to generate specifications for a compelling visualization
by calling the `generate_chart` tool.

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
"""

# Create the agent instance
visualization_agent = LlmAgent(
    name="visualization_agent",
    model="gemini-2.5-pro-preview-06-05", # Using gemini-1.5-pro-latest as gemini-2.5-pro-latest might not be a valid model name
    instruction=VISUALIZATION_AGENT_INSTRUCTION,
    description="Generates specifications for data visualizations by calling the `generate_chart` tool based on provided datasets and user requests.",
    tools=[generate_chart], # Provide the agent with the tool it can use
)