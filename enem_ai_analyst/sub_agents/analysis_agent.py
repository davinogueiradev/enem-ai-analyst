from typing import List, Optional

from google.adk.agents import LlmAgent
from pydantic import BaseModel, Field


class EnemAnalysisOutput(BaseModel):
    """
    Structured output for the ENEM data analysis.
    """
    data_representation: str = Field(
        ...,
        description="Clear explanation of what the provided data represents (e.g., 'This data shows the average math scores for students in different states.')."
    )
    key_insights: List[str] = Field(
        ...,
        description="List of key insights, significant patterns, trends, or anomalies identified in the data. Each insight should be a clear statement. Relate these to the ENEM context where applicable (e.g., 'Students from public schools in the Southeast region showed a higher average in Human Sciences.')."
    )
    question_response: Optional[str] = Field(
        None,
        description="Direct, concise, and data-backed answer if a user's question accompanied the data. If the data can only partially answer or cannot answer the question, this field should clearly state the limitations (e.g., 'Based on the provided data, the average score for X was Y.', or 'The provided data does not contain information about Z, so the question cannot be answered.')."
    )
    summary_of_findings: str = Field(
        ...,
        description="A high-level summary of the main findings from the data. This summary should be easily understandable by a non-technical audience."
    )
    calculations_performed: Optional[List[str]] = Field(
        None,
        description="List of descriptions for any basic calculations performed on the data if they helped in deriving insights (e.g., 'Calculated the average NU_NOTA_MT for students from TP_ESCOLA_DESC = Privada.', 'Determined the percentage of students with TP_SEXO_DESC = Feminino.'). Explicitly state any calculations performed."
    )
    data_limitations_or_warnings: Optional[List[str]] = Field(
        None,
        description="Any general limitations of the provided data or warnings for interpretation (e.g., 'The dataset is a small sample and may not be representative of all ENEM participants.', 'Correlation found does not imply causation.')."
    )

ANALYSIS_AGENT_INSTRUCTION = """
You are the **Analysis Agent** for ENEM-AI Analyst, a specialized component within a multi-agent system built using the Google Agent Development Kit (ADK). Your core responsibility is to **transform raw data into meaningful analytical insights and concise textual summaries**.

**Input**: You will receive raw or pre-processed data (typically tabular) from the Data Agent, along with the context of the user's original query and the analytical goal delegated by the Orchestrator Agent.

**Task**: Your primary task is to **summarize key findings from the provided data** and to **perform relevant calculations** to support deep, correlational, and longitudinal insights.

**Key Responsibilities**:
1.  **Data Interpretation**: Understand the structure and content of the incoming data, identifying key patterns, trends, and anomalies.
2.  **Summary Generation**: **Produce a clear, concise, and insightful textual summary** of the data's findings, directly addressing the user's query intent.
3.  **Analytical Calculations**: Where appropriate, perform calculations such as:
    *   **Year-over-year growth**.
    *   **Correlation coefficients** between numerical variables.
    *   Other statistical measures relevant to the data and query (e.g., averages, distributions, comparisons between groups).
4.  **Insight Extraction**: Focus on extracting and presenting **actionable insights** that go beyond mere description of the data.
5.  **Coherence**: Ensure the analyzed insights directly contribute to answering the user's original question in a coherent and understandable manner.

**Output**: You will provide the **analyzed insights in a textual summary format** to the Orchestrator Agent. This output will be part of the final response delivered to the user, potentially alongside an interactive visualization.

**Performance Goal**: Your analysis should contribute to the overall system's target of achieving a **Response Match Score greater than 0.85**, ensuring high semantic similarity with expected responses.
"""

# Create the agent instance
analysis_agent = LlmAgent(
    name="analysis_agent",
    model="gemini-2.5-flash-preview-05-20",
    instruction=ANALYSIS_AGENT_INSTRUCTION,
    tools=[],
)