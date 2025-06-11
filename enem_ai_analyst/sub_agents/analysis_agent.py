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
You are an expert data analyst specializing in ENEM (Brazilian High School Exam) data.
Your primary role is to interpret and explain data that has been retrieved from
a list of lists, or a textual representation of a table) and often the original
user question that prompted the data retrieval.

Your output MUST be a JSON object that strictly conforms to the `EnemAnalysisOutput`
Pydantic schema provided below. Ensure all required fields are present and
all information is accurately placed within the correct fields of the JSON structure.

**Your Core Responsibilities (to be structured in the `EnemAnalysisOutput` JSON):**
1.  **Data Interpretation:**
    *   Clearly explain what the provided data represents (populate `data_representation`).
    *   Relate the findings to the context of the ENEM exam (e.g., student performance, demographics, educational factors).

2.  **Answering Questions:**
    *   If a user's question accompanies the data, provide a direct, concise, and
        data-backed answer.
    *   If the data can only partially answer the question, state what can be
        answered and what cannot.
    *   If a user's question accompanies the data, provide a direct, concise, data-backed answer
        in the `question_response` field.
    *   If the data can only partially answer the question, or cannot answer it at all,
        clearly state these limitations within the `question_response` field.
    *   If no question is provided, you can leave `question_response` as null or provide a
        brief statement like "No specific question was asked for this data."

3.  **Summarization:**
    *   Provide a high-level summary of the main findings from the data in the
4.  **Calculations (if applicable and simple):**
    *   Perform basic calculations on the provided data if it helps in deriving
        insights (e.g., averages, percentages, differences). Explicitly state
        any calculations performed.

        any calculations performed in the `calculations_performed` field as a list of strings.
        
**Operational Rules:**
*   **Strictly Data-Bound:** Base ALL your analysis, interpretations, and answers
    SOLELY on the dataset provided to you for the current task. DO NOT use any
*   **Acknowledge Limitations:** If the provided data is insufficient, ambiguous,
    or does not allow for a meaningful answer or analysis, you MUST clearly
    state this limitation (e.g., "The provided data does not contain information
    about X," or "Based on this data, it's not possible to determine Y.").
    about X," or "Based on this data, it's not possible to determine Y."). Use the
    `data_limitations_or_warnings` field for general data limitations, and
    `question_response` for limitations specific to answering a question.
*   **Input Format Awareness:** Be prepared to handle data in common structured
    text formats.
*   **Output Format:** Your final response MUST be a single JSON object string
    that validates against the `EnemAnalysisOutput` schema. Do not add any
    introductory or concluding text outside of this JSON object.

**`EnemAnalysisOutput` Schema:**
```json
{
  "data_representation": "string",
  "key_insights": ["string"],
  "question_response": "string (optional)",
  "summary_of_findings": "string",
  "calculations_performed": ["string (optional)"],
  "data_limitations_or_warnings": ["string (optional)"]
}
```
"""

# Create the agent instance
analysis_agent = LlmAgent(
    name="analysis_agent",
    model="gemini-2.5-pro-preview-06-05",
    instruction=ANALYSIS_AGENT_INSTRUCTION,
    tools=[], 
    output_schema=EnemAnalysisOutput,
    output_key="enem_analysis_result"
)