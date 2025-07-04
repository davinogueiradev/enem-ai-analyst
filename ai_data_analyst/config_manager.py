import sqlite3
import os
from cryptography.fernet import Fernet, InvalidToken

# --- Key Management ---
# For a real production app, this key should be managed securely,
# e.g., via a secret manager service (AWS Secrets Manager, GCP Secret Manager, HashiCorp Vault).
# For this local application, we'll load it from an environment variable.
# If not set, we'll generate one and store it in a file for persistence across restarts.
# This file should be added to .gitignore.

KEY_FILE = "secret.key"
if "CONFIG_ENCRYPTION_KEY" in os.environ:
    ENCRYPTION_KEY = os.environ["CONFIG_ENCRYPTION_KEY"].encode()
else:
    if os.path.exists(KEY_FILE):
        with open(KEY_FILE, "rb") as f:
            ENCRYPTION_KEY = f.read()
    else:
        ENCRYPTION_KEY = Fernet.generate_key()
        with open(KEY_FILE, "wb") as f:
            f.write(ENCRYPTION_KEY)
        print(f"Generated new encryption key and saved to {KEY_FILE}. Add this file to .gitignore.")
        print("For production, set the CONFIG_ENCRYPTION_KEY environment variable instead.")

fernet = Fernet(ENCRYPTION_KEY)

# --- Database Management ---
DB_FILE = "configs.db"

def get_db_connection():
    """Establishes a connection to the SQLite database."""
    conn = sqlite3.connect(DB_FILE)
    conn.row_factory = sqlite3.Row
    return conn

def initialize_db():
    """Initializes the database and creates the configurations table if it doesn't exist."""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS configurations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE,
            db_host TEXT NOT NULL,
            db_port INTEGER NOT NULL,
            db_name TEXT NOT NULL,
            db_user TEXT NOT NULL,
            encrypted_password TEXT NOT NULL,
            db_schema TEXT,
            data_context TEXT
        )
    """)
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS chat_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            session_id TEXT NOT NULL,
            role TEXT NOT NULL,
            content TEXT NOT NULL,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()
    conn.close()

def _encrypt(password: str) -> str:
    """Encrypts a password."""
    return fernet.encrypt(password.encode()).decode()

def _decrypt(encrypted_password: str) -> str:
    """Decrypts a password."""
    try:
        return fernet.decrypt(encrypted_password.encode()).decode()
    except InvalidToken:
        # This can happen if the key changes or the data is corrupt
        return "Error: Could not decrypt password."
    except Exception:
        return "Error: Invalid encrypted password format."

def add_config(name, db_host, db_port, db_name, db_user, db_password):
    """Adds a new database configuration."""
    conn = get_db_connection()
    try:
        conn.execute(
            """
            INSERT INTO configurations (name, db_host, db_port, db_name, db_user, encrypted_password)
            VALUES (?, ?, ?, ?, ?, ?)
            """,
            (name, db_host, db_port, db_name, db_user, _encrypt(db_password))
        )
        conn.commit()
    finally:
        conn.close()

# --- Chat History Management ---

from datetime import datetime

def add_chat_message(session_id: str, role: str, content: str):
    """Adds a chat message to the history, using the current time for the timestamp."""
    conn = get_db_connection()
    try:
        # datetime.now() will be patched by freezegun during tests
        current_time = datetime.now()
        conn.execute(
            "INSERT INTO chat_history (session_id, role, content, timestamp) VALUES (?, ?, ?, ?)",
            (session_id, role, content, current_time)
        )
        conn.commit()
    finally:
        conn.close()

def get_chat_history(session_id: str):
    """Retrieves chat history for a given session_id, ordered by timestamp."""
    conn = get_db_connection()
    try:
        messages = conn.execute(
            "SELECT role, content, timestamp FROM chat_history WHERE session_id = ? ORDER BY timestamp ASC",
            (session_id,)
        ).fetchall()
        # Convert Row objects to dictionaries for easier use in Streamlit
        return [{"role": msg["role"], "content": msg["content"], "timestamp": msg["timestamp"]} for msg in messages]
    finally:
        conn.close()

def get_chat_sessions_preview():
    """
    Retrieves a list of all unique chat sessions, with a preview (first user message content and timestamp).
    Sessions are ordered by the timestamp of their first message, descending (newest first).
    """
    conn = get_db_connection()
    try:
        # Get the first message (user or assistant) for each session_id
        # and order sessions by the timestamp of that first message.
        sessions = conn.execute("""
            SELECT
                ch.session_id,
                ch.content AS first_message_content,
                ch.timestamp AS first_message_timestamp,
                ch.role AS first_message_role
            FROM chat_history ch
            INNER JOIN (
                SELECT session_id, MIN(timestamp) AS min_ts
                FROM chat_history
                GROUP BY session_id
            ) AS first_msgs ON ch.session_id = first_msgs.session_id AND ch.timestamp = first_msgs.min_ts
            ORDER BY ch.timestamp DESC
        """).fetchall()

        # For preview, we prefer the first *user* message. If the absolute first message is assistant,
        # we might need a more complex query or post-processing if a user prompt is essential for context.
        # For now, let's keep it simple and use the absolute first message.
        # A more sophisticated approach might be to fetch the first 'user' role message.

        return [
            {
                "session_id": s["session_id"],
                "preview_content": s["first_message_content"][:50] + "..." if len(s["first_message_content"]) > 50 else s["first_message_content"], # Preview first 50 chars
                "timestamp": s["first_message_timestamp"]
            }
            for s in sessions
        ]
    finally:
        conn.close()

def get_all_config_names():
    """Returns a list of all configuration names."""
    conn = get_db_connection()
    try:
        configs = conn.execute("SELECT name FROM configurations ORDER BY name").fetchall()
        return [config['name'] for config in configs]
    finally:
        conn.close()

def get_config_by_name(name):
    """Retrieves a single configuration by its name, decrypting the password."""
    conn = get_db_connection()
    try:
        config_row = conn.execute("SELECT * FROM configurations WHERE name = ?", (name,)).fetchone()
        if config_row:
            config_dict = dict(config_row)
            config_dict['db_password'] = _decrypt(config_dict['encrypted_password'])
            return config_dict
        return None
    finally:
        conn.close()

def update_config(original_name, name, db_host, db_port, db_name, db_user, db_password=None, data_context=None):
    """Updates an existing configuration. If password is not provided, it remains unchanged."""
    conn = get_db_connection()
    try:
        if db_password:
            encrypted_password = _encrypt(db_password)
            conn.execute(
                """
                UPDATE configurations
                SET name = ?, db_host = ?, db_port = ?, db_name = ?, db_user = ?, encrypted_password = ?, data_context = ?
                WHERE name = ?
                """,
                (name, db_host, db_port, db_name, db_user, encrypted_password, data_context, original_name)
            )
        else:
            conn.execute(
                """
                UPDATE configurations
                SET name = ?, db_host = ?, db_port = ?, db_name = ?, db_user = ?, data_context = ?
                WHERE name = ?
                """,
                (name, db_host, db_port, db_name, db_user, data_context, original_name)
            )
        conn.commit()
    finally:
        conn.close()

def update_schema_and_context(name, db_schema, data_context):
    """Updates the schema and data context for a specific configuration."""
    conn = get_db_connection()
    try:
        conn.execute(
            "UPDATE configurations SET db_schema = ?, data_context = ? WHERE name = ?",
            (db_schema, data_context, name)
        )
        conn.commit()
    finally:
        conn.close()

def delete_config(name):
    """Deletes a configuration by its name."""
    conn = get_db_connection()
    try:
        conn.execute("DELETE FROM configurations WHERE name = ?", (name,))
        conn.commit()
    finally:
        conn.close()
