import os
import pathlib

import pytest
from dotenv import find_dotenv, load_dotenv
from google.adk.evaluation.agent_evaluator import AgentEvaluator

pytest_plugins = ("pytest_asyncio",)


@pytest.fixture(scope="session", autouse=True)
def load_env():
    load_dotenv(find_dotenv(".env"))


@pytest.mark.asyncio
async def test_data_agent():
    await AgentEvaluator.evaluate(
        "data_agent",
        str(pathlib.Path(__file__).parent / "data"),
        num_runs=2
    )


@pytest.mark.asyncio
async def test_analysis_agent():
    await AgentEvaluator.evaluate(
        "descriptive_analyzer_agent_tool",
        str(pathlib.Path(__file__).parent / "data"),
        num_runs=1
    )

@pytest.mark.asyncio
async def test_visualization_agent():
    await AgentEvaluator.evaluate(
        "visualization_agent_tool",
        str(pathlib.Path(__file__).parent / "data"),
        num_runs=1
    )

@pytest.mark.asyncio
async def test_narrative_agent():
    await AgentEvaluator.evaluate(
        "narrative_agent_tool",
        str(pathlib.Path(__file__).parent / "data"),
        num_runs=1
    )