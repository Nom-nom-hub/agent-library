# Local Development

Set up Agent Library for local development.

## Prerequisites

- Python 3.11 or higher
- Git
- `uv` (optional but recommended)

## Setting Up Development Environment

### 1. Clone the Repository

```bash
git clone https://github.com/user/agent-library.git
cd agent-library
```

### 2. Create Virtual Environment

Using `venv`:

```bash
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
```

Or using `uv`:

```bash
uv venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
```

### 3. Install in Development Mode

```bash
pip install -e ".[dev]"
```

This installs:
- Agent Library in editable mode
- Development dependencies (pytest, ruff, black)

## Development Workflow

### Running Tests

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src

# Run specific test file
pytest tests/test_file.py

# Run specific test
pytest tests/test_file.py::test_function
```

### Code Formatting

```bash
# Format code with Black
black src tests

# Check formatting without changing files
black --check src tests
```

### Linting

```bash
# Check with Ruff
ruff check src tests

# Fix issues automatically
ruff check --fix src tests
```

### Type Checking

```bash
# Run mypy type checking
mypy src
```

## Project Structure

```
agent-library/
├── src/agent_lib/      # Main CLI and core code
├── templates/          # Task and project templates
├── memory/            # Shared knowledge
├── scripts/           # Automation scripts
├── tests/             # Test suite
├── docs/              # Documentation
├── .github/           # GitHub workflows and config
├── .devcontainer/     # Development container config
└── pyproject.toml     # Project configuration
```

## Making Changes

### Code Changes

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Make your changes
3. Run tests: `pytest`
4. Format code: `black src tests`
5. Lint: `ruff check --fix src tests`
6. Commit with clear message: `git commit -m "feat: your feature"`
7. Push to fork: `git push origin feature/your-feature`
8. Open pull request on GitHub

### Documentation Changes

1. Edit files in `docs/`
2. Check formatting: `black docs`
3. Preview: Many editors have markdown preview
4. Commit and push like code changes

### Adding New Features

For new features:

1. Update `PERSONAS.md` or `AGENTS.md` if relevant
2. Create task template if needed
3. Add tests in `tests/`
4. Update documentation
5. Update `CHANGELOG.md`
6. Update version in `pyproject.toml`

## Using Development Container

If you have Docker and VS Code:

```bash
# Open project in dev container
# VS Code will prompt to reopen in container
```

Or manually:

```bash
# Build container
docker build -f .devcontainer/Dockerfile -t agent-lib-dev .

# Run container
docker run -it -v $(pwd):/workspace agent-lib-dev bash
```

## Common Tasks

### Add a New Persona

1. Document in `PERSONAS.md`
2. Create task template in `templates/tasks/`
3. Add tests in `tests/test_personas.py`
4. Update CLI if agent-specific
5. Add documentation

### Add a New Agent

1. Add to `AGENT_CONFIG` in `src/agent_lib/__init__.py`
2. Update `AGENTS.md`
3. Create templates if needed
4. Add integration tests
5. Update CLI help and README

### Run Full CI Locally

```bash
# Format
black src tests

# Lint
ruff check --fix src tests

# Test
pytest

# All at once (if using Make or shell script)
make lint test
```

## Debugging

### Print Debugging

```python
# In code
print("Debug:", variable)
sys.stdout.flush()  # Force output

# Then run:
pytest -s tests/test_file.py::test_function
```

### Using Debugger

```python
# Add breakpoint
breakpoint()

# Run test, will drop into pdb
pytest tests/test_file.py::test_function
```

### Inspect Project State

```bash
# Show config of created project
cat <project>/.agents/config.yml

# Check project structure
tree <project>
```

## Getting Help

- Check existing issues: https://github.com/user/agent-library/issues
- Review code: `git log --oneline`
- Check tests: `pytest --collect-only`
- See [CONTRIBUTING.md](../CONTRIBUTING.md)

## Performance

For faster development:

1. Use `pytest -k test_pattern` to run specific tests
2. Use `pytest -x` to stop on first failure
3. Install optional tools:
   ```bash
   pip install pytest-watch  # Auto-run tests on change
   pytest-watch tests/
   ```

## Tips

- Keep feature branches focused and small
- Write tests first, implement second
- Commit frequently with clear messages
- Ask questions in discussions if unsure
- Review similar code before implementing

Happy coding!
