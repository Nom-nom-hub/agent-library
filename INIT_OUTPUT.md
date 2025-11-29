# What Users Get When Running `agent-lib init`

When a user runs `agent-lib init my-project --ai claude`, here's what gets created:

## Project Directory Structure

```
my-project/
├── .agents/
│   ├── personas/          # Persona definitions (for reference)
│   ├── tasks/             # Task templates (for reference)
│   ├── context/           # Project state tracking
│   └── config.yml         # Project configuration with AI agent selection
├── src/                   # Source code directory
├── tests/                 # Test directory
├── docs/                  # Documentation directory
```

## Created Configuration File: `.agents/config.yml`

```yaml
# Agent Library Project Configuration

project:
  name: my-project
  ai_agent: claude
  version: 0.1.0

# Personas available in this project
personas:
  - architect
  - implementer
  - debugger
  - reviewer
  - researcher
  - documentarian
  - optimizer
  - tester

# Task types for this project
task_types:
  - planning
  - architecture
  - implementation
  - debugging
  - code_review
  - research
  - documentation
  - optimization
  - testing
```

## What Happens Next

Users can now:

1. **List available personas:**
   ```bash
   agent-lib list personas
   ```

2. **See what task types exist:**
   ```bash
   agent-lib list tasks
   ```

3. **Execute a task with automatic persona selection:**
   ```bash
   agent-lib task "implement user authentication"
   ```
   This will automatically select the right personas (e.g., Implementer + Reviewer) based on the task description.

4. **Check if their AI agent tools are installed:**
   ```bash
   agent-lib check
   ```

## Persona Selection Examples

When users run tasks, the system automatically selects appropriate personas:

- `agent-lib task "implement API endpoint"` → **Implementer + Reviewer**
- `agent-lib task "fix authentication bug"` → **Debugger + Reviewer**  
- `agent-lib task "write unit tests"` → **Tester + Implementer + Reviewer**
- `agent-lib task "design database schema"` → **Architect**
- `agent-lib task "document the API"` → **Documentarian**
- `agent-lib task "optimize query performance"` → **Optimizer + Reviewer**

## The Simple Design

Like spec-kit, agent-lib `init` is intentionally minimal:
- Just creates the directory structure
- Just stores the AI agent selection
- That's it

The persona selection engine and context tracking are utilities that external tools and agents can use, but the CLI itself stays focused and simple.
