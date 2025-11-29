# AGENTS.md

## About Agent Library

**Agent Library** is a dynamic persona-shifting framework that enables AI agents to automatically adapt to task context. Instead of maintaining a single static persona, agents dynamically adopt specialized personas (architect, implementer, debugger, reviewer, etc.) based on the current development task.

The framework supports multiple AI coding assistants, allowing teams to use their preferred tools while automatically shifting between task-specific personas to provide more effective assistance.

---

## General Practices

- Any changes to `src/agent_lib/__init__.py` require a version rev in `pyproject.toml` and addition of entries to `CHANGELOG.md`
- Personas and task mappings should be documented in `PERSONAS.md`
- Agent-specific templates go in `templates/agents/`

## Adding New Agent Support

This section explains how to add support for new AI agents to Agent Library.

### Overview

Agent Library supports multiple AI agents by generating agent-specific command files when initializing projects. Each agent has its own conventions for:

- **Command file formats** (Markdown, TOML, etc.)
- **Directory structures** (`.agents/`, `.claude/`, `.gemini/`, etc.)
- **Command invocation patterns** (slash commands, CLI tools, etc.)
- **Argument passing conventions** (`$ARGUMENTS`, `{{args}}`, etc.)

### Current Supported Agents

| Agent | Directory | Format | CLI Tool | Description |
|-------|-----------|---------|----------|-------------|
| **Claude Code** | `.agents/` | Markdown | `claude` | Anthropic's Claude Code CLI |
| **Gemini CLI** | `.gemini/` | TOML | `gemini` | Google's Gemini CLI |
| **GitHub Copilot** | `.github/` | Markdown | N/A (IDE-based) | GitHub Copilot in VS Code |
| **Cursor** | `.cursor/` | Markdown | `cursor-agent` | Cursor IDE |
| **Amp** | `.agents/` | Markdown | `amp` | Amp CLI |

### Step-by-Step Integration Guide

#### 1. Add to AGENT_CONFIG

**IMPORTANT**: Use the actual CLI tool name as the key.

Add the new agent to the `AGENT_CONFIG` dictionary in `src/agent_lib/__init__.py`:

```python
AGENT_CONFIG = {
    # ... existing agents ...
    "new-agent-cli": {  # Use the ACTUAL CLI tool name
        "name": "New Agent Display Name",
        "folder": ".newagent/",
        "install_url": "https://example.com/install",
        "requires_cli": True,  # True if CLI tool required, False for IDE-based
    },
}
```

**Key Design Principle**: The dictionary key should match the actual executable name.

**Field Explanations**:

- `name`: Human-readable display name
- `folder`: Directory for agent-specific files (relative to project root)
- `install_url`: Installation documentation URL (set to `None` for IDE-based agents)
- `requires_cli`: Whether the agent requires a CLI tool check during initialization

#### 2. Update CLI Help Text

Update the `--ai` parameter help text in the `init()` command to include the new agent:

```python
ai: str = typer.Option(None, "--ai", help="AI assistant: claude, gemini, copilot, cursor-agent, amp, or new-agent-cli")
```

#### 3. Create Agent Template Files

Create persona template files in `templates/agents/{agent_name}/`:

```
templates/agents/new-agent/
├── architect-persona.md
├── implementer-persona.md
├── debugger-persona.md
└── reviewer-persona.md
```

Each template file contains the persona instructions specific to that agent.

#### 4. Update README

Add the new agent to the "Supported AI Agents" section in `README.md`.

#### 5. Add to .devcontainer (Optional)

For agents with VS Code extensions, add to `.devcontainer/devcontainer.json`:

```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        "[New Agent Extension ID]"
      ]
    }
  }
}
```

## Persona-Agent Mapping

Each agent may have slightly different ways of expressing personas. Create agent-specific persona templates:

```yaml
# templates/agents/claude/architect.md
---
agent: claude
persona: architect
---

You are an Architect persona for Claude Code.
[Claude-specific instructions]
```

## Agent Categories

### CLI-Based Agents

Require a command-line tool to be installed:

- **Claude Code**: `claude` CLI
- **Gemini CLI**: `gemini` CLI
- **Amp**: `amp` CLI

### IDE-Based Agents

Work within integrated development environments:

- **GitHub Copilot**: Built into VS Code
- **Cursor**: Built into Cursor IDE

## Command File Formats

### Markdown Format

Used by: Claude, Cursor, Amp

**Standard format:**

```markdown
---
description: "Persona instruction"
agent: agent-name
persona: persona-type
---

Persona-specific instructions with $ARGUMENTS and {SCRIPT} placeholders.
```

### TOML Format

Used by: Gemini

```toml
description = "Persona instruction"
agent = "gemini"
persona = "architect"

prompt = """
Persona-specific instructions with {{args}} placeholders.
"""
```

## Argument Patterns

Different agents use different argument placeholders:

- **Markdown/prompt-based**: `$ARGUMENTS`
- **TOML-based**: `{{args}}`
- **Script placeholders**: `{SCRIPT}` (replaced with actual script path)

## Testing New Agent Integration

1. **Configuration test**: Verify agent is in AGENT_CONFIG
2. **CLI test**: Test `agent-lib init --ai <agent>` command
3. **File generation**: Verify correct directory structure and files are created
4. **Persona selection**: Test that personas are correctly selected for tasks
5. **Template generation**: Verify persona templates are generated for the agent

## Common Pitfalls

1. **Using shorthand keys instead of actual CLI tool names**: Always use the actual executable name as the AGENT_CONFIG key
2. **Forgetting to document formats**: Specify the command file format clearly
3. **Incorrect `requires_cli` value**: Set to `True` only for agents that have CLI tools
4. **Inconsistent help text**: Update all user-facing text consistently
5. **Missing agent-specific templates**: Each agent should have persona templates

---

*This documentation should be updated whenever new agents are added.*
