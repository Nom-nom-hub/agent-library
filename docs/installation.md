# Installation

Detailed instructions for installing Agent Library.

## System Requirements

- **Python**: 3.11 or higher
- **OS**: Windows, macOS, or Linux
- **AI Agent**: One of the supported agents (Claude, Gemini, Copilot, Cursor, Amp)

## Installation Methods

### Method 1: Global Installation with `uv` (Recommended)

This is the easiest method and works on all platforms.

**Prerequisites**: Install `uv` from https://github.com/astral-sh/uv

```bash
uv tool install agent-lib --from git+https://github.com/user/agent-library.git
```

Then use directly:
```bash
agent-lib --help
```

To upgrade:
```bash
uv tool install agent-lib --force --from git+https://github.com/user/agent-library.git
```

### Method 2: Local Installation from Source

```bash
# Clone the repository
git clone https://github.com/user/agent-library.git
cd agent-library

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install in development mode
pip install -e .
```

### Method 3: One-time Usage

Run without installing:

```bash
uvx --from git+https://github.com/user/agent-library.git agent-lib init my-project
```

## Verify Installation

Check that everything is working:

```bash
agent-lib --version
agent-lib check
```

You should see:
- Version number
- Status of installed AI agents
- Available tools

## AI Agent Installation

### Claude Code

```bash
pip install claude-cli
# or visit https://docs.anthropic.com/en/docs/claude-code/setup
```

### Gemini CLI

```bash
# Visit https://github.com/google-gemini/gemini-cli
```

### GitHub Copilot

Built into VS Code. Install the extension:
- Open VS Code
- Search for "GitHub Copilot"
- Install the extension

### Cursor

Download from https://cursor.sh/

### Amp

Visit https://ampcode.com/ for installation

## Next Steps

1. **Create your first project**:
   ```bash
   agent-lib init my-project
   ```

2. **Read the Quick Start**:
   See [quickstart.md](./quickstart.md)

3. **Choose your AI agent**:
   During project initialization, select your preferred agent

## Troubleshooting

### Command not found

If you get "command not found" for `agent-lib`:

1. Verify installation: `pip list | grep agent-lib`
2. Check PATH: `which agent-lib` or `where agent-lib`
3. Reinstall: `pip install --force-reinstall agent-lib`

### Python version issues

Agent Library requires Python 3.11+. Check your version:

```bash
python --version
```

### Agent detection errors

During `agent-lib init`, if your agent isn't detected:

1. Verify the agent is installed
2. Check it's in your PATH: `which claude` (or `where claude` on Windows)
3. Use `--ignore-agent-tools` flag to skip validation

## Uninstallation

To remove Agent Library:

```bash
# If installed with uv
uv tool uninstall agent-lib

# If installed with pip
pip uninstall agent-lib
```

## Getting Help

- Run `agent-lib --help` for CLI help
- See [SUPPORT.md](../SUPPORT.md) for support options
- Check [docs/](./README.md) for full documentation
