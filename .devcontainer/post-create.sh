#!/bin/bash
set -e

echo "Setting up Agent Library development environment..."

# Install uv (fast Python package installer)
echo "📦 Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.cargo/bin:$PATH"

# Install the package in development mode
echo "📦 Installing agent-lib in development mode..."
cd /workspace || cd "$(pwd)"
pip install -e ".[dev]"

# Run initial checks
echo "🔍 Running initial checks..."
ruff check . --fix || true
black . || true

echo "✅ Development environment ready!"
echo ""
echo "Quick start:"
echo "  agent-lib --help      # See available commands"
echo "  agent-lib check       # Check for installed agents"
echo "  agent-lib init myapp  # Create a new project"
