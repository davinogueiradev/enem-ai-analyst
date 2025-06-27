import os
import json
import pandas as pd
from sqlalchemy import create_engine, text


def list_tables_and_schemas() -> str:
    """
    Connects to a PostgreSQL database, retrieves all table names from the public schema,
    and then gets the schema for each table.

    Returns:
        A single string containing the formatted schemas for all tables, or an error message.
    """
    engine = None
    try:
        print("DEBUG: Attempting to list tables and schemas...")
        db_user = os.environ.get("POSTGRES_USER", "user")
        db_password = os.environ.get("POSTGRES_PASSWORD", "password")
        db_host = os.environ.get("POSTGRES_HOST", "localhost")
        db_port = os.environ.get("POSTGRES_PORT", "5432")
        db_name = os.environ.get("POSTGRES_DB", "enem_data")

        database_url = f"postgresql+psycopg2://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"
        engine = create_engine(database_url)

        with engine.connect() as connection:
            # Get all table names from the public schema
            query = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'"
            tables_df = pd.read_sql_query(text(query), connection)
            table_names = tables_df['table_name'].tolist()

            if not table_names:
                return json.dumps({"error": "No tables found in the public schema."})

            all_schemas = ""
            for table_name in table_names:
                schema_str = get_table_schema(table_name, connection) # Pass connection to reuse
                if "error" in schema_str:
                    # If there is an error, just append it to the list of schemas
                    all_schemas += f"Error for table {table_name}: {schema_str}\n\n"
                else:
                    all_schemas += schema_str + "\n"

            return all_schemas.strip()

    except Exception as e:
        print(f"DEBUG: Failed to list tables and schemas: {str(e)}")
        return json.dumps({"error": f"Failed to list tables and schemas: {str(e)}"})
    finally:
        if engine:
            engine.dispose()
        print("DEBUG: Database engine disposed.")


def get_table_schema(table_name: str, connection=None) -> str:
    """
    Retrieves the schema for a specific table using an existing connection or a new one.
    """
    if connection:
        return _get_table_schema_with_connection(table_name, connection)
    
    engine = None
    try:
        db_user = os.environ.get("POSTGRES_USER", "user")
        db_password = os.environ.get("POSTGRES_PASSWORD", "password")
        db_host = os.environ.get("POSTGRES_HOST", "localhost")
        db_port = os.environ.get("POSTGRES_PORT", "5432")
        db_name = os.environ.get("POSTGRES_DB", "enem_data")
        database_url = f"postgresql+psycopg2://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"
        engine = create_engine(database_url)
        with engine.connect() as conn:
            return _get_table_schema_with_connection(table_name, conn)
    except Exception as e:
        return json.dumps({"error": f"Failed to get table schema: {str(e)}"})
    finally:
        if engine:
            engine.dispose()


def _get_table_schema_with_connection(table_name: str, connection) -> str:
    """
    Core logic to get table schema, assuming connection is provided.
    """
    query = f"""
    SELECT column_name, data_type
    FROM information_schema.columns
    WHERE table_name = '{table_name}';
    """
    df = pd.read_sql_query(text(query), connection)

    if df.empty:
        return json.dumps({"error": f"Table '{table_name}' not found or has no columns."})

    schema_str = f"**Table: `{table_name}`**\n"
    for _, row in df.iterrows():
        schema_str += f"- `{row['column_name']}` ({row['data_type']})\n"

    return schema_str


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
            return json.dumps(
                {"error": f"Database Security Error: Attempted to perform a write operation on a read-only connection. Original error: {str(e)}"})
        return json.dumps({"error": f"Database query failed: {str(e)}"})
    finally:
        if engine:
            engine.dispose()  # Dispose of the engine to close all connections in the pool
        print("DEBUG: Database engine disposed.")
