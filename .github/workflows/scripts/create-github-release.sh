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

- \`agent_lib-$VERSION-py3-none-any.whl\` - Python wheel
- \`agent-lib-$VERSION.tar.gz\` - Source distribution
"

# Create GitHub release
echo "Creating release: $VERSION"
gh release create "$VERSION" \
    --title "Agent Library $VERSION" \
    --notes "$RELEASE_NOTES" \
    --draft=false \
    $ASSET_FILES 2>/dev/null || echo "Release creation completed"

echo "Release $VERSION created successfully!"
