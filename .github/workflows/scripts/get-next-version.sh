#!/usr/bin/env bash

# Get the next version number for Agent Library releases
# Uses semantic versioning based on git tags

set -e

# Get the latest tag
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")

# Remove 'v' prefix
LATEST_VERSION=${LATEST_TAG#v}

# Parse version components
IFS='.' read -r MAJOR MINOR PATCH <<< "$LATEST_VERSION"

# Increment patch version (minor bump for releases)
MINOR=$((MINOR + 1))
PATCH=0

NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"
NEW_TAG="v${NEW_VERSION}"

# Output for GitHub Actions
echo "latest_tag=$LATEST_TAG" >> "$GITHUB_OUTPUT"
echo "latest_version=$LATEST_VERSION" >> "$GITHUB_OUTPUT"
echo "new_version=$NEW_VERSION" >> "$GITHUB_OUTPUT"
echo "new_tag=$NEW_TAG" >> "$GITHUB_OUTPUT"

echo "Latest: $LATEST_TAG ($LATEST_VERSION)"
echo "Next: $NEW_TAG ($NEW_VERSION)"
