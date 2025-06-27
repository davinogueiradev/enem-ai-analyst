import pytest
from google.adk.evaluation.agent_evaluator import AgentEvaluator

@pytest.mark.asyncio
async def test_data_agent_evals():
    """Test the data agent using the defined evalset."""
    await AgentEvaluator.evaluate(
        agent_module="enem_ai_analyst.sub_agents.data_agent",
        eval_dataset_file_path_or_dir="tests/integration/fixtures/data_agent/eval_set_data_agent.test.json"
    )
