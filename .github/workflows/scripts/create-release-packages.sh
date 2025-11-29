#!/usr/bin/env bash

# Create release packages for Agent Library
# Generates main distribution packages and agent-specific templates

set -e

VERSION="${1:?Version required}"

echo "Creating release packages for version: $VERSION"

# Create output directory
RELEASE_DIR=".genreleases"
mkdir -p "$RELEASE_DIR"

# Update version in pyproject.toml
sed -i "s/version = \".*\"/version = \"$VERSION\"/" pyproject.toml

# Build Python packages
echo "Building Python packages..."
python -m pip install --upgrade build
python -m build

# Copy built distributions
cp dist/* "$RELEASE_DIR/" 2>/dev/null || true

# Build agent-specific template packages
echo "Building agent-specific templates..."
AGENTS=("amp" "auggie" "bob" "claude" "codebuddy" "codex" "copilot" "cursor-agent" "gemini" "kilocode" "opencode" "q" "qwen" "roo" "shai" "windsurf")

for agent in "${AGENTS[@]}"; do
    echo "Creating template package for: $agent"
    
    # Create temp directory for agent template
    TEMP_DIR="/tmp/agent-lib-template-$agent"
    mkdir -p "$TEMP_DIR"
    
    # Copy base templates
    cp -r templates "$TEMP_DIR/"
    cp PERSONAS.md "$TEMP_DIR/" 2>/dev/null || true
    cp AGENTS.md "$TEMP_DIR/" 2>/dev/null || true
    cp README.md "$TEMP_DIR/" 2>/dev/null || true
    
    # Create agent-specific config
    mkdir -p "$TEMP_DIR/.agents"
    cat > "$TEMP_DIR/.agents/config.yml" <<EOF
# Agent Library Configuration for $agent

project:
  ai_agent: $agent
  version: $VERSION

# Personas available for this project
personas:
  - architect
  - implementer
  - debugger
  - reviewer
  - researcher
  - documentarian
  - optimizer
  - tester

# Task types
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
EOF
    
    # Create README with agent-specific instructions
    cat > "$TEMP_DIR/.agents/README.md" <<EOF
# Agent Library Setup - $agent

This package contains templates and configuration for using Agent Library with **$agent**.

## Getting Started

1. Copy the contents of this package into your project
2. Use the templates in \`templates/tasks/\` to define your tasks
3. Reference PERSONAS.md for available personas
4. Run your agent with appropriate persona selection

## Files Included

- \`templates/tasks/\` - Task templates for different persona types
- \`PERSONAS.md\` - Persona definitions and expertise areas
- \`AGENTS.md\` - Agent configuration and integration guide
- \`config.yml\` - Pre-configured for $agent
EOF
    
    # Create zip package
    PACKAGE_NAME="agent-lib-template-${agent}-v${VERSION}.zip"
    cd "$TEMP_DIR"
    zip -r "$RELEASE_DIR/$PACKAGE_NAME" . -q
    cd - > /dev/null
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    
    echo "  ✓ Created: $PACKAGE_NAME"
done

echo ""
echo "Release packages created in: $RELEASE_DIR"

# List created files
ls -lah "$RELEASE_DIR/" || true

# Output for GitHub Actions
echo "release_dir=$RELEASE_DIR" >> "$GITHUB_OUTPUT"
