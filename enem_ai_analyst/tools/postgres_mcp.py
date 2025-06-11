import os
import psycopg2
import json
import pandas as pd

def execute_sql(query: str) -> str:
    """
    Connects to a PostgreSQL database, executes a read-only SQL query,
    and returns the result as a JSON string. This function is designed
    to be a "tool" for an ADK agent.

    Args:
        query: The SQL SELECT statement to be executed.

    Returns:
        A string containing the query result in JSON format, or an
        error message if the query fails or is not a SELECT statement.
    """
    # --- SECURITY GUARDRAIL ---
    # Ensure only SELECT statements are executed to prevent data modification.
    if not query.strip().upper().startswith("SELECT"):
        return json.dumps({"error": "Security Error: Only SELECT statements are allowed."})

    conn = None
    try:
        print("DEBUG: Attempting to connect to the database...")
        # Connect to the database using environment variables
        conn = psycopg2.connect(
            host=os.environ.get("POSTGRES_HOST", "localhost"),
            port=os.environ.get("POSTGRES_PORT", "5432"),
            dbname=os.environ.get("POSTGRES_DB", "enem_data"),
            user=os.environ.get("POSTGRES_USER", "user"),
            password=os.environ.get("POSTGRES_PASSWORD", "password"),
        )
        df = pd.read_sql_query(query, conn)
        return df.to_json(orient='records')

    except Exception as e:
        return json.dumps({"error": f"Database query failed: {str(e)}"})
    finally:
        if conn:
            conn.close()
        print("DEBUG: Database connection closed.")