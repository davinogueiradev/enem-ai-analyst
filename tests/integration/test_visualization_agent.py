import pytest
from google.adk.evaluation.agent_evaluator import AgentEvaluator

@pytest.mark.asyncio
async def test_visualization_agent_evals():
    """Test the visualization agent using the defined evalset."""
    await AgentEvaluator.evaluate(
        agent_module="enem_ai_analyst.sub_agents.visualization_agent",
        eval_dataset_file_path_or_dir="tests/integration/fixtures/visualization_agent/eval_set_visualization_agent.test.json"
    )
