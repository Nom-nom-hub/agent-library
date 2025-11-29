#!/usr/bin/env bash

# Create release packages for Agent Library
# Generates distribution packages for different platforms

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

echo "Release packages created in: $RELEASE_DIR"

# List created files
ls -lah "$RELEASE_DIR/" || true

# Output for GitHub Actions
echo "release_dir=$RELEASE_DIR" >> "$GITHUB_OUTPUT"
