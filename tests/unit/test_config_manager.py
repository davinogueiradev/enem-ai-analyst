import pytest
import os
import sqlite3
import shutil
from datetime import datetime, timedelta
from freezegun import freeze_time

# Adjust path to import config_manager from the parent directory
import sys
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))
from ai_data_analyst import config_manager

# --- Test Database Fixture ---
TEST_DB_FILE = "test_configs.db"

@pytest.fixture(autouse=True)
def temporary_db(monkeypatch):
    """
    Fixture to set up and tear down a temporary database for each test.
    It also ensures the config_manager uses this test database.
    """
    # Ensure a clean state before each test
    if os.path.exists(TEST_DB_FILE):
        os.remove(TEST_DB_FILE)
    if os.path.exists(config_manager.KEY_FILE): # Assuming KEY_FILE is in the same dir as DB_FILE for testing
        os.remove(config_manager.KEY_FILE)

    # Monkeypatch DB_FILE in config_manager to use the test DB
    monkeypatch.setattr(config_manager, 'DB_FILE', TEST_DB_FILE)

    # Monkeypatch KEY_FILE to avoid interference or use a test-specific key
    test_key_file = "test_secret.key"
    monkeypatch.setattr(config_manager, 'KEY_FILE', test_key_file)
    # Generate a temporary key for testing if it doesn't exist, or ensure it's clean
    if os.path.exists(test_key_file):
        os.remove(test_key_file)

    # Re-initialize Fernet with a predictable key or let it generate one for the test
    # For simplicity, we'll let it generate a new one for each test run if KEY_FILE is deleted.
    # A more robust approach might involve setting a fixed test key.
    from cryptography.fernet import Fernet
    new_key = Fernet.generate_key()
    with open(test_key_file, "wb") as f:
        f.write(new_key)
    monkeypatch.setattr(config_manager, 'ENCRYPTION_KEY', new_key)
    monkeypatch.setattr(config_manager, 'fernet', Fernet(new_key))

    # Initialize the database schema in the test DB
    config_manager.initialize_db()

    yield # Test runs here

    # Teardown: Remove the test database and key file after the test
    if os.path.exists(TEST_DB_FILE):
        os.remove(TEST_DB_FILE)
    if os.path.exists(test_key_file):
        os.remove(test_key_file)

# --- Test Functions ---

def test_get_chat_sessions_preview_empty(temporary_db):
    """Test preview generation when there is no chat history."""
    previews = config_manager.get_chat_sessions_preview()
    assert previews == []

@freeze_time("2023-01-01 10:00:00")
def test_get_chat_sessions_preview_single_session(temporary_db):
    """Test preview for a single chat session."""
    session_id_1 = "session_A"
    config_manager.add_chat_message(session_id_1, "user", "Hello, this is the first message.")
    freezer = freeze_time("2023-01-01 10:01:00")
    freezer.start()
    config_manager.add_chat_message(session_id_1, "assistant", "Hi there!")
    freezer.stop()

    previews = config_manager.get_chat_sessions_preview()

    assert len(previews) == 1
    assert previews[0]["session_id"] == session_id_1
    assert previews[0]["preview_content"] == "Hello, this is the first message." # Exact match as it's short
    assert previews[0]["timestamp"] == "2023-01-01 10:00:00" # Timestamp of the first message

@freeze_time("2023-01-01 12:00:00")
def test_get_chat_sessions_preview_multiple_sessions_ordering(temporary_db):
    """Test preview for multiple sessions, checking content and ordering."""
    session_id_1 = "session_older"
    session_id_2 = "session_newer"

    # Session 1 (Older)
    config_manager.add_chat_message(session_id_1, "user", "This is an older conversation that will be quite long to test truncation.")
    with freeze_time("2023-01-01 12:01:00"):
        config_manager.add_chat_message(session_id_1, "assistant", "Response in older chat.")

    # Session 2 (Newer) - started later but its first message timestamp will make it "newer"
    with freeze_time("2023-01-01 13:00:00"):
        config_manager.add_chat_message(session_id_2, "user", "A newer chat started here.")
    with freeze_time("2023-01-01 13:01:00"):
        config_manager.add_chat_message(session_id_2, "assistant", "Response in newer chat.")

    previews = config_manager.get_chat_sessions_preview()

    assert len(previews) == 2

    # Newest should be first (session_id_2)
    assert previews[0]["session_id"] == session_id_2
    assert previews[0]["preview_content"] == "A newer chat started here."
    assert previews[0]["timestamp"] == "2023-01-01 13:00:00"

    # Older should be second (session_id_1)
    assert previews[1]["session_id"] == session_id_1
    assert previews[1]["preview_content"] == "This is an older conversation that will be quite l..." # Truncated
    assert previews[1]["timestamp"] == "2023-01-01 12:00:00"

@freeze_time("2023-01-02 09:00:00")
def test_get_chat_sessions_preview_first_message_is_assistant(temporary_db):
    """Test where the very first recorded message in a session is from the assistant."""
    # This case might be unusual but the function should handle it by picking that first message.
    session_id_1 = "session_assistant_first"

    config_manager.add_chat_message(session_id_1, "assistant", "Assistant initiated this conversation somehow.")
    with freeze_time("2023-01-02 09:01:00"):
        config_manager.add_chat_message(session_id_1, "user", "User responds later.")

    previews = config_manager.get_chat_sessions_preview()

    assert len(previews) == 1
    assert previews[0]["session_id"] == session_id_1
    assert previews[0]["preview_content"] == "Assistant initiated this conversation somehow."
    assert previews[0]["timestamp"] == "2023-01-02 09:00:00"

@freeze_time("2023-01-03 10:00:00")
def test_get_chat_sessions_preview_content_truncation(temporary_db):
    """Test that long message content is correctly truncated."""
    session_id_1 = "session_long_msg"
    long_message = "This is a very long message that is definitely over fifty characters long, so it should be truncated for the preview."
    config_manager.add_chat_message(session_id_1, "user", long_message)

    previews = config_manager.get_chat_sessions_preview()

    assert len(previews) == 1
    assert previews[0]["session_id"] == session_id_1
    expected_preview = long_message[:50] + "..."
    assert previews[0]["preview_content"] == expected_preview
    assert len(previews[0]["preview_content"]) == 53 # 50 chars + "..."
    assert previews[0]["timestamp"] == "2023-01-03 10:00:00"

# To run these tests, navigate to the root of the project and run:
# python -m pytest tests/unit/test_config_manager.py
# (Ensure pytest and freezegun are installed: pip install pytest freezegun)
# (You might need to create tests/unit/__init__.py if it causes import issues)
