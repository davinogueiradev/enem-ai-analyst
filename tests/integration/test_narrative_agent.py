import pytest
from google.adk.evaluation.agent_evaluator import AgentEvaluator

@pytest.mark.asyncio
async def test_narrative_agent_evals():
    """Test the narrative agent using the defined evalset."""
    await AgentEvaluator.evaluate(
        agent_module="ai_data_analyst.sub_agents.narrative_agent",
        eval_dataset_file_path_or_dir="tests/integration/fixtures/narrative_agent/eval_set_narrative_agent.test.json"
    )
