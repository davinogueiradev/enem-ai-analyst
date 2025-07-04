import logging
import json
from typing import Dict, Any, Tuple, Optional

logger = logging.getLogger(__name__)

def validate_chart_spec(chart_spec: Dict[str, Any]) -> Tuple[bool, Optional[str]]:
    """
    Validates an Altair chart specification to ensure it has all required components.

    Args:
        chart_spec: The chart specification dictionary

    Returns:
        Tuple containing (is_valid, error_message)
    """
    # Check for required components
    if not isinstance(chart_spec, dict):
        return False, "Chart specification must be a dictionary"

    # Check for schema
    if '$schema' not in chart_spec:
        logger.warning("Chart spec missing $schema field")
        # This is not a strict requirement, but helpful for validation

    # Check for mark type
    if 'mark' not in chart_spec:
        return False, "Chart specification missing 'mark' field"

    # Check for encoding
    if 'encoding' not in chart_spec:
        return False, "Chart specification missing 'encoding' field"

    encoding = chart_spec['encoding']
    if not isinstance(encoding, dict):
        return False, "'encoding' must be a dictionary"

    # Ensure there's at least one encoding channel (x, y, color, etc.)
    if not any(key in encoding for key in ['x', 'y', 'color', 'size', 'theta']):
        return False, "Chart encoding must include at least one channel (x, y, color, etc.)"

    # Check for data
    if 'data' not in chart_spec:
        return False, "Chart specification missing 'data' field"

    data = chart_spec['data']
    if not isinstance(data, dict):
        return False, "'data' must be a dictionary"

    # Check if data has values
    if 'values' not in data:
        return False, "Chart data must include 'values' field"

    # Check if data is properly formatted JSON serializable object
    try:
        json.dumps(data)
    except (TypeError, OverflowError) as e:
        return False, f"Chart data is not JSON serializable: {str(e)}"

    values = data['values']
    if not isinstance(values, list) or len(values) == 0:
        return False, "Chart data values must be a non-empty list"

    # All checks passed
    return True, None
