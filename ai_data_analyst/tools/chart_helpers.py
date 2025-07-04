import pandas as pd
import json
import logging
from typing import Dict, List, Any, Optional, Tuple

logger = logging.getLogger(__name__)

def prepare_data_for_chart(data: str) -> Tuple[pd.DataFrame, List[str], Dict[str, Any]]:
    """
    Prepares data for chart generation by analyzing the dataset structure
    and determining appropriate columns for visualization.

    Args:
        data: JSON string or list of dictionaries representing the dataset

    Returns:
        Tuple containing (dataframe, column_names, chart_recommendations)
    """
    # Parse data if it's a string
    if isinstance(data, str):
        try:
            data = json.loads(data)
        except json.JSONDecodeError as e:
            logger.error(f"Invalid JSON data provided: {str(e)}")
            return pd.DataFrame(), [], {"error": f"Invalid JSON data: {str(e)}"}

    # Convert to DataFrame
    df = pd.DataFrame(data)
    if df.empty:
        return df, [], {"error": "Empty dataset"}

    # Get column names and types
    column_names = df.columns.tolist()

    # Identify column types
    categorical_columns = []
    numeric_columns = []
    datetime_columns = []
    text_columns = []

    for col in column_names:
        if pd.api.types.is_numeric_dtype(df[col]):
            numeric_columns.append(col)
        elif pd.api.types.is_datetime64_dtype(df[col]):
            datetime_columns.append(col)
        elif df[col].nunique() < len(df) * 0.5:  # Heuristic for categorical columns
            categorical_columns.append(col)
        else:
            text_columns.append(col)

    # Make recommendations for chart types based on data structure
    recommendations = {
        "chart_type": None,
        "x_column": None,
        "y_column": None,
        "options": {}
    }

    # Simple heuristics for chart recommendations
    if len(numeric_columns) >= 1 and len(categorical_columns) >= 1:
        # Bar chart or pie chart (category vs number)
        recommendations["chart_type"] = "bar"
        recommendations["x_column"] = categorical_columns[0]
        recommendations["y_column"] = numeric_columns[0]
    elif len(numeric_columns) >= 2:
        # Scatter plot (number vs number)
        recommendations["chart_type"] = "scatter"
        recommendations["x_column"] = numeric_columns[0]
        recommendations["y_column"] = numeric_columns[1]
    elif len(datetime_columns) >= 1 and len(numeric_columns) >= 1:
        # Line chart (time vs number)
        recommendations["chart_type"] = "line"
        recommendations["x_column"] = datetime_columns[0]
        recommendations["y_column"] = numeric_columns[0]
    elif len(categorical_columns) >= 1 and len(numeric_columns) == 0:
        # Histogram/count of categories
        recommendations["chart_type"] = "histogram"
        recommendations["x_column"] = categorical_columns[0]

    # If we have multiple categorical columns, suggest a grouped chart
    if len(categorical_columns) >= 2 and len(numeric_columns) >= 1:
        recommendations["options"]["group_column"] = categorical_columns[1]
        recommendations["chart_type"] = "grouped_bar"

    return df, column_names, recommendations

def analyze_chart_data(df: pd.DataFrame) -> Dict[str, Any]:
    """
    Analyzes a dataframe to extract key statistics and insights that could be 
    useful for chart annotations or descriptions.

    Args:
        df: Pandas DataFrame containing the data to analyze

    Returns:
        Dictionary with key statistics and insights
    """
    if df.empty:
        return {"error": "Empty dataset"}

    analysis = {
        "row_count": len(df),
        "column_count": len(df.columns),
        "columns": {},
        "correlations": {},
        "insights": []
    }

    # Analyze each column
    for col in df.columns:
        col_data = {
            "type": str(df[col].dtype),
            "missing": df[col].isna().sum(),
            "unique_values": df[col].nunique()
        }

        if pd.api.types.is_numeric_dtype(df[col]):
            col_data.update({
                "min": float(df[col].min()) if not pd.isna(df[col].min()) else None,
                "max": float(df[col].max()) if not pd.isna(df[col].max()) else None,
                "mean": float(df[col].mean()) if not pd.isna(df[col].mean()) else None,
                "median": float(df[col].median()) if not pd.isna(df[col].median()) else None
            })

            # Check for outliers (simple IQR method)
            q1 = df[col].quantile(0.25)
            q3 = df[col].quantile(0.75)
            iqr = q3 - q1
            lower_bound = q1 - 1.5 * iqr
            upper_bound = q3 + 1.5 * iqr
            outliers = df[(df[col] < lower_bound) | (df[col] > upper_bound)][col]
            col_data["outliers"] = len(outliers)

            if len(outliers) > 0:
                analysis["insights"].append(f"Column '{col}' has {len(outliers)} potential outliers")

        elif pd.api.types.is_object_dtype(df[col]) or pd.api.types.is_categorical_dtype(df[col]):
            # Get top categories for categorical columns
            value_counts = df[col].value_counts()
            if len(value_counts) <= 10:  # Only include if we have a reasonable number of categories
                col_data["categories"] = {str(k): int(v) for k, v in value_counts.items()}

                # Check for dominant category
                if value_counts.iloc[0] > len(df) * 0.5:
                    analysis["insights"].append(
                        f"Column '{col}' has a dominant category '{value_counts.index[0]}' "
                        f"({value_counts.iloc[0]/len(df)*100:.1f}% of data)"
                    )

        analysis["columns"][col] = col_data

    # Calculate correlations between numeric columns
    numeric_cols = df.select_dtypes(include=['number']).columns
    if len(numeric_cols) >= 2:
        corr_matrix = df[numeric_cols].corr()
        for i, col1 in enumerate(numeric_cols):
            for col2 in numeric_cols[i+1:]:
                corr_value = corr_matrix.loc[col1, col2]
                if not pd.isna(corr_value):
                    # Only include strong correlations
                    if abs(corr_value) > 0.7:
                        analysis["correlations"][f"{col1}-{col2}"] = float(corr_value)
                        strength = "strong positive" if corr_value > 0 else "strong negative"
                        analysis["insights"].append(
                            f"There is a {strength} correlation ({corr_value:.2f}) "
                            f"between '{col1}' and '{col2}'"
                        )

    return analysis

def format_chart_description(analysis: Dict[str, Any], chart_type: str, 
                             x_column: Optional[str] = None, 
                             y_column: Optional[str] = None) -> str:
    """
    Generates a human-readable description of a chart based on data analysis.

    Args:
        analysis: Dictionary with data analysis results
        chart_type: The type of chart being described
        x_column: The column used for the x-axis
        y_column: The column used for the y-axis

    Returns:
        A formatted string describing the chart and key insights
    """
    description = []

    # Basic chart description
    if chart_type and x_column:
        if chart_type == "bar" and y_column:
            description.append(f"This bar chart shows {y_column} by {x_column}.")
        elif chart_type == "line" and y_column:
            description.append(f"This line chart shows the trend of {y_column} over {x_column}.")
        elif chart_type == "pie" and y_column:
            description.append(f"This pie chart shows the distribution of {y_column} across different {x_column} categories.")
        elif chart_type == "scatter" and y_column:
            description.append(f"This scatter plot shows the relationship between {x_column} and {y_column}.")
        elif chart_type == "histogram":
            description.append(f"This histogram shows the distribution of {x_column}.")
        elif chart_type == "donut" and y_column:
            description.append(f"This donut chart shows the proportion of {y_column} for each {x_column}.")
        elif chart_type == "stacked_bar" and y_column:
            description.append(f"This stacked bar chart shows {y_column} by {x_column} with breakdown by category.")
        elif chart_type == "grouped_bar" and y_column:
            description.append(f"This grouped bar chart compares {y_column} across {x_column} grouped by category.")

    # Add data volume info
    if "row_count" in analysis:
        description.append(f"The chart contains data for {analysis['row_count']} records.")

    # Add insights about the variables
    if x_column and x_column in analysis.get("columns", {}):
        x_data = analysis["columns"][x_column]
        if "unique_values" in x_data:
            description.append(f"There are {x_data['unique_values']} unique values in the {x_column} column.")

    if y_column and y_column in analysis.get("columns", {}):
        y_data = analysis["columns"][y_column]
        if all(k in y_data for k in ["min", "max", "mean"]):
            description.append(
                f"The {y_column} ranges from {y_data['min']:.2f} to {y_data['max']:.2f} "
                f"with an average of {y_data['mean']:.2f}."
            )

    # Add top insights
    insights = analysis.get("insights", [])
    if insights:
        top_insights = insights[:3]  # Limit to 3 most important insights
        description.append("\nKey insights:")
        for insight in top_insights:
            description.append(f"- {insight}")

    return "\n".join(description)
