import os
import json
import pandas as pd
from sqlalchemy import create_engine, text

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

    engine = None
    try:
        print("DEBUG: Attempting to connect to the database using SQLAlchemy...")
        # Construct the database URL for SQLAlchemy
        db_user = os.environ.get("POSTGRES_USER", "user")
        db_password = os.environ.get("POSTGRES_PASSWORD", "password")
        db_host = os.environ.get("POSTGRES_HOST", "localhost")
        db_port = os.environ.get("POSTGRES_PORT", "5432")
        db_name = os.environ.get("POSTGRES_DB", "enem_data")

        database_url = f"postgresql+psycopg2://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"
        
        # Add connect_args={'readonly': True} to ensure the session is read-only
        # This requires psycopg2 version 2.8+
        engine = create_engine(database_url, execution_options={"postgresql_readonly": True})
        
        # Using a context manager for the connection is good practice
        with engine.connect() as connection:

            # The connection is now established in read-only mode.
            df = pd.read_sql_query(text(query), connection)

            records = df.to_json(orient='records')
            print(f"DEBUG: Query executed successfully. {records}")
        
            return records

    except Exception as e:
        print(f"DEBUG: Database query failed: {str(e)}")
        # Check if the error is due to trying to write in a read-only transaction
        if "read-only transaction" in str(e).lower():
             return json.dumps({"error": f"Database Security Error: Attempted to perform a write operation on a read-only connection. Original error: {str(e)}"})
        return json.dumps({"error": f"Database query failed: {str(e)}"})
    finally:
        if engine:
            engine.dispose() # Dispose of the engine to close all connections in the pool
        print("DEBUG: Database engine disposed.")