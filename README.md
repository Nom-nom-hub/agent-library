# Agent Library

A dynamic persona-shifting framework for AI agents that automatically adapt to task context. Agents dynamically adopt specialized personas (architect, implementer, debugger, reviewer, etc.) based on the current development task, enabling more effective and context-aware assistance.

## Key Concept

Instead of agents maintaining a single static persona, **Agent Library** enables agents to dynamically shift between specialized personas during development. When a user runs a command or task, the agent automatically:

1. **Analyzes the task context** - understands what needs to be done
2. **Selects appropriate personas** - chooses the right expertise mix
3. **Adopts the persona(s)** - shifts into that mode with specific instructions and constraints
4. **Executes the task** - completes work with persona-specific approach
5. **Shifts as needed** - changes personas as development proceeds and context evolves

## Features

- **Automatic Persona Selection** - Tasks define required personas; agent automatically adopts them
- **Multi-Persona Support** - Single agent can shift between architect, implementer, debugger, reviewer, researcher, documentarian, optimizer, tester
- **Context-Aware** - Personas adapt based on project phase, completed work, and development history
- **Multi-Agent Support** - Works with Claude, Gemini, Copilot, Cursor, and other agents
- **Extensible** - Easy to define new personas and task types
- **Cross-Platform** - Windows, macOS, Linux support

## Getting Started

```bash
# Initialize a new agent-library project
agent-lib init my-project --ai claude

# Execute a task (agent automatically selects appropriate personas)
agent-lib task "implement user authentication" --context backend
```

## Project Structure

```
agent-library/
├── src/
│   └── agent_lib/
│       └── __init__.py          # Main CLI entry point (all-in-one like spec-kit)
├── templates/                    # Persona and task templates
├── examples/                      # Example projects
├── docs/                          # Documentation
├── pyproject.toml
├── README.md
└── PERSONAS.md                    # Persona system documentation
```

## Architecture Approach

Following spec-kit's philosophy, Agent Library uses a **single-file CLI** (`__init__.py`) approach for simplicity and portability, similar to how spec-kit implements its core functionality. This allows:

- Easy distribution as a single tool
- Minimal dependencies
- Direct execution without complex imports
- Clear context and state management

## Documentation

- **[PERSONAS.md](./PERSONAS.md)** - Persona system and definitions
- **[docs/](./docs/)** - Complete documentation
