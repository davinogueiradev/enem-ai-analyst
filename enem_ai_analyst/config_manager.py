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
