import pytest
from google.adk.evaluation.agent_evaluator import AgentEvaluator

@pytest.mark.asyncio
async def test_planner_agent_evals():
    """Test the planner agent using the defined evalset."""
    await AgentEvaluator.evaluate(
        agent_module="enem_ai_analyst.sub_agents.planner_agent",
        eval_dataset_file_path_or_dir="tests/integration/fixtures/planner_agent/eval_set_planner_agent.test.json"
    )
