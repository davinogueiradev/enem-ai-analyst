Product Requirements Document: AI Data Analyst
Version: 1.0
Date: June 9, 2024
Author: Gemini (acting as experienced Product Manager)
Status: Final

1. Introduction & Executive Summary
This document outlines the product requirements for AI Data Analyst, a multi-agent data analysis platform designed to make vast and complex Brazilian educational datasets, including multiple years of ENEM (Exame Nacional do Ensino Médio) and the Censo Escolar, accessible through a natural language interface.

The core of this product is a sophisticated system of AI agents, built using the Google Agent Development Kit (ADK), that work collaboratively to understand user queries, perform complex data analysis across multiple sources and timeframes, and deliver insights. Users will interact with the system via a simple chat interface, receiving answers in the form of text summaries, tables, and interactive visualizations rendered in a Streamlit frontend. All data will be securely managed and queried from a PostgreSQL MCP database.

The primary goal of AI Data Analyst is to democratize access to educational data in Brazil, enabling researchers, journalists, and policymakers to uncover deep, correlational, and longitudinal insights in minutes, not weeks, within a secure and responsible framework.

2. The Problem
Analyzing Brazilian educational microdata is a significant challenge for several reasons:

Massive, Disparate & Longitudinal Datasets: The primary datasets (ENEM, Censo Escolar) are enormous. Analyzing trends requires joining and comparing data across many years, a task complicated by schema changes and evolving data definitions over time.

High Technical Barrier: Meaningful analysis requires advanced technical skills in data processing, database management (complex JOINs across years), and statistical programming. This excludes a vast majority of potential users.

Time-Consuming: Even for experienced analysts, the process of cleaning, merging, and exploring these combined datasets is laborious. Answering a simple trend analysis question can take days or weeks.

Rigid Tools: Traditional BI dashboards lack the flexibility for the kind of exploratory, conversational analysis needed to uncover novel insights across different data sources and time periods.

This friction means that valuable insights remain locked away in the raw data.

3. User Personas
Isabela, the Education Researcher: 🎓

Needs: To quickly test hypotheses that span multiple datasets and years, such as "How has the correlation between school internet access and science scores evolved over the last 5 years?".

Carlos, the Journalist: ✍️

Needs: To quickly ask questions like "Show me the trend of average math scores for public school students in the Northeast region from 2018 to 2023." and get a clear, simple visualization for his articles.

Mariana, the Public Policy Advisor: 🏛️

Needs: Reliable, high-level summaries and specific trend data to support policy proposals and evaluate the long-term impact of past decisions. She values accuracy and traceability above all else.

4. Solution: A Multi-Agent Approach
ENEM-AI Analyst allows users to "chat" with the combined, multi-year ENEM and Censo Escolar microdata. Specialized AI agents work in the background to deliver answers.

5. AI System Specifications
This section details the technical requirements and strategy for the AI components.

5.1. Model Requirements
Core Model: The system will use a Google Gemini family model (e.g., Gemini 1.5 Pro) accessed via API. This model is chosen for its large context window, advanced reasoning capabilities, and proficiency in understanding and generating code (SQL).

Fine-Tuning: No initial fine-tuning is planned for the MVP. We will leverage prompt engineering and providing schema context (few-shot prompting) to achieve high accuracy.

Context Window: The model's large context window will be utilized to provide detailed database schema information, table descriptions, column definitions, and examples within the prompt to the Data Agent.

Latency: The target for a p90 response time (from user query to displayed result) is under 15 seconds for moderately complex queries.

Performance: The Data Agent must achieve >90% accuracy in generating syntactically correct and logically sound SQL for our test benchmark.

5.2. Data Requirements
Data Collection: All historical microdata for ENEM and Censo Escolar will be sourced directly from the official INEP data portal.

Data Preparation: A significant engineering effort will be dedicated to creating a unified schema or a set of views to harmonize column names and data types across different years, documenting all schema changes, and indexing all tables for performant queries.

5.3. Prompt Engineering
Strategy: A ReAct (Reason-Act) framework will be implemented for the agents.

Orchestrator Agent Prompt: The initial prompt will instruct the Orchestrator to act as a "project manager," breaking down the user's query into sub-tasks for other agents.

Data Agent Meta-Prompt: The prompt sent to the Data Agent will be dynamically constructed and include: Role, Task, Context (schema), Constraints, and Examples (few-shot learning).

5.4. Testing & Measurement
Framework: We will adopt the built-in evaluation framework provided by the Google Agent Development Kit (ADK) to assess both the final answer and the agent's decision-making process (trajectory).

Test Artifacts: We will build a comprehensive evalset.json file containing at least 100 representative user questions, each with a hand-written, validated SQL query and a reference response.

Automated Testing: Our CI/CD pipeline will automatically run the adk eval command-line tool against the comprehensive evalset on every commit to the main branch.

Metrics:

Tool Trajectory Score: Measures the correctness of the generated SQL. Target: >0.95.

Response Match Score: Semantic similarity score for the natural language response. Target: >0.85.

SQL Execution Success Rate: % of generated queries that execute without error. Target: >98%.

5.5. Security & Safety Patterns
To build a trustworthy and secure agent, we will implement a multi-layered defense strategy.

Principle of Least Privilege (In-Tool Guardrail): The Data Agent's tool will connect to the database with read-only credentials, making destructive operations (UPDATE, DELETE, DROP) impossible.

Query Validation Guardrail (Input Screening): A non-AI function will validate all generated SQL, ensuring it is a SELECT statement and blocking introspection keywords (e.g., information_schema).

Configurable Model Safety Filters (Output Screening): We will leverage Gemini's built-in safety filters, setting categories like Harassment and Hate Speech to BLOCK_MEDIUM_AND_ABOVE.

System Prompt Hardening: The Data Agent's prompt will include explicit instructions to ONLY write SELECT queries and refuse any request to modify data or query system tables.

Privacy Guardrail (De-anonymization Prevention): The system will check the number of rows in a result set. If it's below a threshold (e.g., 10), the result will be withheld to protect individual privacy.

5.6. Risks & Mitigation
This section identifies key risks and how the patterns from section 5.5 mitigate them.

Risk: Malicious SQL Injection

Mitigation: Addressed by read-only credentials, the Query Validation Guardrail, and hardened system prompts.

Risk: AI Hallucination (Incorrect SQL)

Mitigation: The "Show me the query" feature provides user transparency. Rigorous testing against our evalset.json will track and reduce errors.

Risk: Data Privacy Violation

Mitigation: The Privacy Guardrail (row count check) directly prevents the display of overly specific query results.

Risk: Harmful Content Generation

Mitigation: The configurable Gemini safety filters are the primary defense against this.

6. Features & Requirements (MVP)
Core Agentic Engine (Google ADK): Implement Orchestrator, Data, Analysis, and Visualization agents. The Data Agent must handle complex, multi-year, multi-table queries with JOINs and UNIONs.

Data & Backend (PostgreSQL MCP): Ingest and harmonize all historical ENEM and Censo Escolar microdata.

Frontend & User Experience (Streamlit): Provide a simple chat interface, display text and visualizations, offer a "Show query" button, and allow for copying/downloading results.

Correlational & Longitudinal Analysis: The system must be able to answer questions that compare data across datasets and across multiple years, presenting trend data as line charts.

7. Success Metrics
Task Success Rate (Complex Queries): The percentage of queries in our evalset that pass the defined Tool Trajectory and Response Match score thresholds. (Target: >75% for MVP).

User Engagement: Weekly active users and queries per session.

Time-to-Insight: Drastically reduce the time required to answer complex questions (from days to minutes), measured via user interviews.

User Satisfaction (NPS): Gauge user loyalty and satisfaction through regular surveys.

8. Future Roadmap (Post-MVP)
Proactive Insights: Develop an agent that proactively surfaces interesting trends or anomalies in the data for users to explore.

User Dashboards: Allow users to save their favorite queries and visualizations into a personal dashboard.

Advanced Analytics: Incorporate more advanced statistical models (e.g., regression analysis) and machine learning capabilities into the Analysis Agent.