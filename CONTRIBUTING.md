# Contributing to Agent Library

Thank you for your interest in contributing to Agent Library! We welcome contributions from everyone.

## Code of Conduct

Please read and follow our [Code of Conduct](./CODE_OF_CONDUCT.md).

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected behavior
- Actual behavior
- Your environment (OS, Python version, agent used)

### Suggesting Enhancements

We welcome suggestions for improvements:
- Clear description of the enhancement
- Use case and motivation
- Possible implementation approach
- Related issues or discussions

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/your-feature`)
3. **Make your changes**
4. **Test your changes** (`pytest`)
5. **Update documentation** if needed
6. **Commit your changes** with clear messages
7. **Push to your fork**
8. **Open a Pull Request** with description of changes

## Development Setup

### Prerequisites
- Python 3.11+
- `uv` for package management
- Git

### Local Development

```bash
# Clone the repository
git clone https://github.com/yourusername/agent-library.git
cd agent-library

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install in development mode
pip install -e ".[dev]"

# Run tests
pytest

# Run linting
ruff check .
black --check .
```

## Project Structure

- `src/agent_lib/` - Main CLI implementation
- `templates/` - Task templates and project templates
- `memory/` - Shared knowledge and guidelines
- `scripts/` - Automation scripts (bash and powershell)
- `tests/` - Test suite
- `docs/` - Documentation
- `.github/workflows/` - CI/CD pipelines

## Adding New Personas

1. Document in `PERSONAS.md`
2. Create task template in `templates/tasks/`
3. Update `AGENT_CONFIG` in CLI if agent-specific
4. Add tests for persona selection
5. Update documentation

## Adding New Agents

1. Add to `AGENT_CONFIG` in `src/agent_lib/__init__.py`
2. Update `AGENTS.md` with integration guide
3. Create agent-specific templates if needed
4. Update CLI help text
5. Update README.md
6. Test initialization and context generation

## Code Style

- Use Black for formatting (`black src tests`)
- Use Ruff for linting (`ruff check .`)
- Follow PEP 8 conventions
- Include docstrings for public functions
- Keep functions focused and testable

## Testing

- Write tests for new functionality
- Run `pytest` to validate changes
- Aim for >80% code coverage
- Test both success and failure paths

## Documentation

- Update README.md for user-facing changes
- Update AGENTS.md for agent integration changes
- Update PERSONAS.md for persona system changes
- Keep docs in sync with code
- Include examples where helpful

## Commit Messages

Write clear, descriptive commit messages:

```
[type] Brief description

Longer explanation if needed. Reference issues with #issue-number.

- Bullet points for multiple changes
- Keep it focused and clear
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

## Release Process

1. Update version in `pyproject.toml`
2. Update `CHANGELOG.md`
3. Create pull request
4. After merge, tag release: `git tag v0.x.x`
5. Push tags: `git push --tags`
6. Automated workflows create release

## Questions?

Feel free to:
- Open a discussion on GitHub
- Check existing issues and PRs
- Review documentation
- Ask in pull request comments

Thank you for contributing!
