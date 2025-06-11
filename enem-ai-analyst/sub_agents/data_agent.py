from google.adk.agents import LlmAgent
from ..tools.postgres_mcp import execute_sql

# --- MODEL CONTEXT PROTOCOL (MCP) ---
# This is the "context" we provide to the model. It contains clear instructions,
# security rules, and the full database schema so the LLM knows exactly
# what tables and columns it can work with.

DATABASE_SCHEMA_CONTEXT = """
**Database Schema:**

**Table: `enem_2023_enriched`**
- `NU_INSCRICAO` (BIGINT): Unique participant inscription number.
- `NU_ANO` (INTEGER): Year of the exam (e.g., 2023).
- `TP_FAIXA_ETARIA` (INTEGER): Code for the age group of the participant.
- `TP_FAIXA_ETARIA_DESC` (TEXT): Description of the age group (e.g., '19 anos'), corresponding to `TP_FAIXA_ETARIA`.
- `TP_SEXO` (TEXT): Code for the sex of the participant (e.g., 'M', 'F').
- `TP_SEXO_DESC` (TEXT): Description of the sex (e.g., 'Masculino', 'Feminino'), corresponding to `TP_SEXO`.
- `TP_ESTADO_CIVIL` (INTEGER): Code for the marital status of the participant.
- `TP_ESTADO_CIVIL_DESC` (TEXT): Description of the marital status, corresponding to `TP_ESTADO_CIVIL`.
- `TP_COR_RACA` (INTEGER): Code for the color/race of the participant.
- `TP_COR_RACA_DESC` (TEXT): Description of the color/race (e.g., 'Preta', 'Parda'), corresponding to `TP_COR_RACA`.
- `TP_NACIONALIDADE` (INTEGER): Code for the nationality of the participant.
- `TP_NACIONALIDADE_DESC` (TEXT): Description of the nationality, corresponding to `TP_NACIONALIDADE`.
- `TP_ST_CONCLUSAO` (INTEGER): Code for high school completion status.
- `TP_ST_CONCLUSAO_DESC` (TEXT): Description of high school completion status, corresponding to `TP_ST_CONCLUSAO`.
- `TP_ANO_CONCLUIU` (INTEGER): Code for the year of high school completion.
- `TP_ANO_CONCLUIU_DESC` (TEXT): Description of the year of high school completion, corresponding to `TP_ANO_CONCLUIU`.
- `TP_ESCOLA` (INTEGER): Code for the type of school (e.g., 1=Public, 2=Private).
- `TP_ESCOLA_DESC` (TEXT): Description of the type of school, corresponding to `TP_ESCOLA`.
- `TP_ENSINO` (INTEGER): Code for the type of regular education during high school.
- `TP_ENSINO_DESC` (TEXT): Description of the type of regular education, corresponding to `TP_ENSINO`.
- `IN_TREINEIRO` (INTEGER): Indicates if the participant is a "treineiro" (testing for experience, e.g., 0=No, 1=Yes).
- `IN_TREINEIRO_DESC` (TEXT): Description if the participant is a "treineiro" (e.g., 'Sim', 'Não'), corresponding to `IN_TREINEIRO`.
- `CO_MUNICIPIO_ESC` (BIGINT): Municipality code of the school (IBGE code).
- `NO_MUNICIPIO_ESC` (TEXT): Municipality name of the school.
- `CO_UF_ESC` (INTEGER): State (UF) code of the school (IBGE code).
- `SG_UF_ESC` (TEXT): State (UF) abbreviation of the school.
- `TP_DEPENDENCIA_ADM_ESC` (INTEGER): Code for the administrative dependency of the school.
- `TP_DEPENDENCIA_ADM_ESC_DESC` (TEXT): Description of the administrative dependency of the school (e.g., Federal, State, Municipal, Private), corresponding to `TP_DEPENDENCIA_ADM_ESC`.
- `TP_LOCALIZACAO_ESC` (INTEGER): Code for the location of the school.
- `TP_LOCALIZACAO_ESC_DESC` (TEXT): Description of the location of the school (e.g., Urban, Rural), corresponding to `TP_LOCALIZACAO_ESC`.
- `TP_SIT_FUNC_ESC` (INTEGER): Code for the operational status of the school.
- `TP_SIT_FUNC_ESC_DESC` (TEXT): Description of the operational status of the school (e.g., Active, Extinct), corresponding to `TP_SIT_FUNC_ESC`.
- `CO_MUNICIPIO_PROVA` (BIGINT): Municipality code where the exam was taken (IBGE code).
- `NO_MUNICIPIO_PROVA` (TEXT): Municipality name where the exam was taken.
- `CO_UF_PROVA` (INTEGER): State (UF) code where the exam was taken (IBGE code).
- `SG_UF_PROVA` (TEXT): State (UF) abbreviation where the exam was taken.
- `TP_PRESENCA_CN` (INTEGER): Code for presence in the Natural Sciences exam (e.g., 0=Absent, 1=Present, 2=Eliminated).
- `TP_PRESENCA_CN_DESC` (TEXT): Description of presence in the Natural Sciences exam, corresponding to `TP_PRESENCA_CN`.
- `TP_PRESENCA_CH` (INTEGER): Code for presence in the Human Sciences exam.
- `TP_PRESENCA_CH_DESC` (TEXT): Description of presence in the Human Sciences exam, corresponding to `TP_PRESENCA_CH`.
- `TP_PRESENCA_LC` (INTEGER): Code for presence in the Languages and Codes exam.
- `TP_PRESENCA_LC_DESC` (TEXT): Description of presence in the Languages and Codes exam, corresponding to `TP_PRESENCA_LC`.
- `TP_PRESENCA_MT` (INTEGER): Code for presence in the Mathematics exam.
- `TP_PRESENCA_MT_DESC` (TEXT): Description of presence in the Mathematics exam, corresponding to `TP_PRESENCA_MT`.
- `CO_PROVA_CN` (INTEGER): Code of the Natural Sciences exam booklet.
- `CO_PROVA_CN_DESC` (TEXT): Description/Color of the Natural Sciences exam booklet, corresponding to `CO_PROVA_CN`.
- `CO_PROVA_CH` (INTEGER): Code of the Human Sciences exam booklet.
- `CO_PROVA_CH_DESC` (TEXT): Description/Color of the Human Sciences exam booklet, corresponding to `CO_PROVA_CH`.
- `CO_PROVA_LC` (INTEGER): Code of the Languages and Codes exam booklet.
- `CO_PROVA_LC_DESC` (TEXT): Description/Color of the Languages and Codes exam booklet, corresponding to `CO_PROVA_LC`.
- `CO_PROVA_MT` (INTEGER): Code of the Mathematics exam booklet.
- `CO_PROVA_MT_DESC` (TEXT): Description/Color of the Mathematics exam booklet, corresponding to `CO_PROVA_MT`.
- `NU_NOTA_CN` (NUMERIC): Natural Sciences score.
- `NU_NOTA_CH` (NUMERIC): Human Sciences score.
- `NU_NOTA_LC` (NUMERIC): Languages and Codes score.
- `NU_NOTA_MT` (NUMERIC): Mathematics score.
- `TX_RESPOSTAS_CN` (TEXT): Participant's answers for the Natural Sciences exam.
- `TX_RESPOSTAS_CH` (TEXT): Participant's answers for the Human Sciences exam.
- `TX_RESPOSTAS_LC` (TEXT): Participant's answers for the Languages and Codes exam.
- `TX_RESPOSTAS_MT` (TEXT): Participant's answers for the Mathematics exam.
- `TP_LINGUA` (INTEGER): Code for foreign language choice (e.g., 0=English, 1=Spanish).
- `TP_LINGUA_DESC` (TEXT): Description of the foreign language choice, corresponding to `TP_LINGUA`.
- `TX_GABARITO_CN` (TEXT): Official answer key for the Natural Sciences exam.
- `TX_GABARITO_CH` (TEXT): Official answer key for the Human Sciences exam.
- `TX_GABARITO_LC` (TEXT): Official answer key for the Languages and Codes exam.
- `TX_GABARITO_MT` (TEXT): Official answer key for the Mathematics exam.
- `TP_STATUS_REDACAO` (INTEGER): Code for the status of the essay.
- `TP_STATUS_REDACAO_DESC` (TEXT): Description of the essay status (e.g., "Sem problemas", "Em Branco", "Anulada"), corresponding to `TP_STATUS_REDACAO`.
- `NU_NOTA_COMP1` (NUMERIC): Essay score - Competency 1.
- `NU_NOTA_COMP2` (NUMERIC): Essay score - Competency 2.
- `NU_NOTA_COMP3` (NUMERIC): Essay score - Competency 3.
- `NU_NOTA_COMP4` (NUMERIC): Essay score - Competency 4.
- `NU_NOTA_COMP5` (NUMERIC): Essay score - Competency 5.
- `NU_NOTA_REDACAO` (NUMERIC): Essay total score.
- `Q001` (TEXT): Answer code for socioeconomic questionnaire question 1.
- `Q001_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 1 (e.g., 'Nunca estudou.'), corresponding to `Q001`.
- `Q002` (TEXT): Answer code for socioeconomic questionnaire question 2.
- `Q002_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 2, corresponding to `Q002`.
- `Q003` (TEXT): Answer code for socioeconomic questionnaire question 3.
- `Q003_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 3, corresponding to `Q003`.
- `Q004` (TEXT): Answer code for socioeconomic questionnaire question 4.
- `Q004_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 4, corresponding to `Q004`.
- `Q005` (TEXT): Answer code for socioeconomic questionnaire question 5.
- `Q005_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 5, corresponding to `Q005`.
- `Q006` (TEXT): Answer code for socioeconomic questionnaire question 6.
- `Q006_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 6, corresponding to `Q006`.
- `Q007` (TEXT): Answer code for socioeconomic questionnaire question 7.
- `Q007_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 7, corresponding to `Q007`.
- `Q008` (TEXT): Answer code for socioeconomic questionnaire question 8.
- `Q008_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 8, corresponding to `Q008`.
- `Q009` (TEXT): Answer code for socioeconomic questionnaire question 9.
- `Q009_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 9, corresponding to `Q009`.
- `Q010` (TEXT): Answer code for socioeconomic questionnaire question 10.
- `Q010_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 10, corresponding to `Q010`.
- `Q011` (TEXT): Answer code for socioeconomic questionnaire question 11.
- `Q011_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 11, corresponding to `Q011`.
- `Q012` (TEXT): Answer code for socioeconomic questionnaire question 12.
- `Q012_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 12, corresponding to `Q012`.
- `Q013` (TEXT): Answer code for socioeconomic questionnaire question 13.
- `Q013_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 13, corresponding to `Q013`.
- `Q014` (TEXT): Answer code for socioeconomic questionnaire question 14.
- `Q014_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 14, corresponding to `Q014`.
- `Q015` (TEXT): Answer code for socioeconomic questionnaire question 15.
- `Q015_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 15, corresponding to `Q015`.
- `Q016` (TEXT): Answer code for socioeconomic questionnaire question 16.
- `Q016_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 16, corresponding to `Q016`.
- `Q017` (TEXT): Answer code for socioeconomic questionnaire question 17.
- `Q017_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 17, corresponding to `Q017`.
- `Q018` (TEXT): Answer code for socioeconomic questionnaire question 18.
- `Q018_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 18, corresponding to `Q018`.
- `Q019` (TEXT): Answer code for socioeconomic questionnaire question 19.
- `Q019_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 19, corresponding to `Q019`.
- `Q020` (TEXT): Answer code for socioeconomic questionnaire question 20.
- `Q020_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 20, corresponding to `Q020`.
- `Q021` (TEXT): Answer code for socioeconomic questionnaire question 21.
- `Q021_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 21, corresponding to `Q021`.
- `Q022` (TEXT): Answer code for socioeconomic questionnaire question 22.
- `Q022_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 22, corresponding to `Q022`.
- `Q023` (TEXT): Answer code for socioeconomic questionnaire question 23.
- `Q023_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 23, corresponding to `Q023`.
- `Q024` (TEXT): Answer code for socioeconomic questionnaire question 24.
- `Q024_DESC` (TEXT): Description of
 answer for socioeconomic questionnaire question 24, corresponding to `Q024`.
- `Q025` (TEXT): Answer code for socioeconomic questionnaire question 25.
- `Q025_DESC` (TEXT): Description of answer for socioeconomic questionnaire question 25, corresponding to `Q025`.
"""

# The instruction for the Data Agent.
DATA_AGENT_INSTRUCTION = f"""
You are an expert PostgreSQL data engineer. Your sole purpose is to convert a
user's question into a secure, read-only `SELECT` SQL query to retrieve
information from the ENEM database.

**RULES:**
1.  **SECURITY:** You **MUST NOT** generate any SQL that modifies the database
    (e.g., INSERT, UPDATE, DELETE, DROP). Your one and only task is to write
    `SELECT` statements.
2.  **GROUNDING:** You **MUST** only use the tables and columns defined in the
    schema provided below. Do not invent columns or tables.
3.  **RESPONSE:** If a question cannot be answered with the available schema,
    you must state that you cannot answer. Otherwise, generate the SQL query.
4.  **ACTION:** After generating the SQL, you must call the `execute_sql` tool
    with the query you created to get the data.

{DATABASE_SCHEMA_CONTEXT}
"""

# Create the agent instance
data_agent = LlmAgent(
    name="data_agent",
    # Using a powerful model is key for good SQL generation
    model="gemini-2.5-pro-preview-06-05", # Using gemini-1.5-pro-latest as gemini-2.5-pro-latest might not be a valid model name
    instruction=DATA_AGENT_INSTRUCTION,
    description="Generates and executes SQL queries against the ENEM database.",
    # Provide the agent with the tool it can use
    tools=[execute_sql],
)