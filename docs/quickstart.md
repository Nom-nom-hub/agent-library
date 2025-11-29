# Quick Start

Get Agent Library up and running in 5 minutes.

## Prerequisites

- Python 3.11 or higher
- One of: Claude Code, Gemini CLI, GitHub Copilot, Cursor, or Amp
- Git (optional but recommended)

## Installation

Install Agent Library globally using `uv`:

```bash
uv tool install agent-lib --from git+https://github.com/user/agent-library.git
```

Or install locally:

```bash
git clone https://github.com/user/agent-library.git
cd agent-library
pip install -e .
```

## Create a Project

```bash
agent-lib init my-first-app
cd my-first-app
```

You'll be prompted to select your AI agent. Choose your preferred tool.

## Project Structure

Your new project has:

```
my-first-app/
├── .agents/              # Agent configuration
│   ├── config.yml        # Project config
│   ├── personas/         # Persona definitions
│   ├── tasks/            # Task definitions
│   └── context/          # Project state
├── src/                  # Your source code
├── tests/                # Test files
└── docs/                 # Documentation
```

## Run a Task

Execute a task with automatic persona selection:

```bash
agent-lib task "implement user authentication" --context backend
```

Agent Library will:
1. Analyze the task
2. Select appropriate personas (e.g., Architect, Implementer, Tester)
3. Provide context-specific guidance
4. Help you complete the task

## Check Your Setup

Verify everything is working:

```bash
agent-lib check
```

This shows:
- Installed AI agents
- Available personas
- Project configuration

## List Personas and Tasks

See what's available:

```bash
agent-lib list personas  # Show all personas
agent-lib list tasks     # Show available task types
```

## Next Steps

- **Read [PERSONAS.md](../PERSONAS.md)** - Understand each persona
- **Check [docs/](./README.md)** - Full documentation
- **Review [templates/tasks/](../templates/tasks/)** - Task examples
- **See [CONTRIBUTING.md](../CONTRIBUTING.md)** - How to contribute

## Getting Help

- Run `agent-lib --help` for CLI help
- See [SUPPORT.md](../SUPPORT.md) for support options
- Check [docs/](./README.md) for detailed guides
- Open an issue on GitHub for bugs

Happy developing!
