import pytest
from google.adk.evaluation.agent_evaluator import AgentEvaluator

@pytest.mark.asyncio
async def test_orchestrator_agent_evals():
    """Test the orchestrator agent using the defined evalset."""
    await AgentEvaluator.evaluate(
        agent_module="enem_ai_analyst.agent",
        eval_dataset_file_path_or_dir="tests/integration/fixtures/orchestrator_agent/eval_set_orchestrator_agent.test.json"
    )
