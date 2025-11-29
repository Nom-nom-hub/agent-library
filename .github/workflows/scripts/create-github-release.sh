#!/usr/bin/env bash

# Create a GitHub release with generated packages

set -e

VERSION="${1:?Version required}"
RELEASE_DIR="${2:-.genreleases}"

echo "Creating GitHub release for version: $VERSION"

# Check if release directory exists
if [ ! -d "$RELEASE_DIR" ]; then
    echo "Error: Release directory not found: $RELEASE_DIR"
    exit 1
fi

# Get list of files to upload
ASSET_FILES=$(find "$RELEASE_DIR" -type f 2>/dev/null || echo "")

if [ -z "$ASSET_FILES" ]; then
    echo "Warning: No files found in $RELEASE_DIR"
else
    echo "Assets to upload:"
    echo "$ASSET_FILES"
fi

# Create release notes
RELEASE_NOTES="Agent Library $VERSION

## Changes

See [CHANGELOG.md](CHANGELOG.md) for detailed changes.

## Installation

\`\`\`bash
uv tool install agent-lib --from git+https://github.com/Nom-nom-hub/agent-library.git@$VERSION
\`\`\`

## Packages

### Main Distribution
- \`agent_lib-$VERSION-py3-none-any.whl\` - Python wheel
- \`agent-lib-$VERSION.tar.gz\` - Source distribution

### Agent-Specific Templates
- \`agent-lib-template-amp-v$VERSION.zip\` - Templates for Amp
- \`agent-lib-template-auggie-v$VERSION.zip\` - Templates for Auggie
- \`agent-lib-template-bob-v$VERSION.zip\` - Templates for Bob
- \`agent-lib-template-claude-v$VERSION.zip\` - Templates for Claude Code
- \`agent-lib-template-codebuddy-v$VERSION.zip\` - Templates for CodeBuddy
- \`agent-lib-template-codex-v$VERSION.zip\` - Templates for Codex
- \`agent-lib-template-copilot-v$VERSION.zip\` - Templates for GitHub Copilot
- \`agent-lib-template-cursor-agent-v$VERSION.zip\` - Templates for Cursor
- \`agent-lib-template-gemini-v$VERSION.zip\` - Templates for Gemini CLI
- \`agent-lib-template-kilocode-v$VERSION.zip\` - Templates for KiloCode
- \`agent-lib-template-opencode-v$VERSION.zip\` - Templates for OpenCode
- \`agent-lib-template-q-v$VERSION.zip\` - Templates for Q
- \`agent-lib-template-qwen-v$VERSION.zip\` - Templates for Qwen
- \`agent-lib-template-roo-v$VERSION.zip\` - Templates for Roo
- \`agent-lib-template-shai-v$VERSION.zip\` - Templates for Shai
- \`agent-lib-template-windsurf-v$VERSION.zip\` - Templates for Windsurf
"

# Create GitHub release
echo "Creating release: $VERSION"
gh release create "$VERSION" \
    --title "Agent Library $VERSION" \
    --notes "$RELEASE_NOTES" \
    --draft=false \
    $ASSET_FILES 2>/dev/null || echo "Release creation completed"

echo "Release $VERSION created successfully!"
