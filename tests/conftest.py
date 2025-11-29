"""Pytest configuration and fixtures."""

import shutil
import tempfile
from pathlib import Path

import pytest


@pytest.fixture
def temp_project():
    """Create a temporary project directory for testing."""
    temp_dir = tempfile.mkdtemp(prefix="agent-lib-test-")
    yield Path(temp_dir)
    # Cleanup
    shutil.rmtree(temp_dir, ignore_errors=True)


@pytest.fixture
def mock_agent_config():
    """Mock agent configuration."""
    return {
        "claude": {
            "name": "Claude Code",
            "folder": ".agents/",
            "install_url": "https://docs.anthropic.com/",
            "requires_cli": True,
        },
        "copilot": {
            "name": "GitHub Copilot",
            "folder": ".github/",
            "install_url": None,
            "requires_cli": False,
        },
    }


@pytest.fixture
def mock_personas():
    """Mock persona configuration."""
    return {
        "architect": {
            "name": "Architect",
            "expertise": ["design", "planning"],
            "primary_tasks": ["architecture"],
        },
        "implementer": {
            "name": "Implementer",
            "expertise": ["coding", "testing"],
            "primary_tasks": ["implementation"],
        },
    }
