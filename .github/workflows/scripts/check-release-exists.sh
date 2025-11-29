#!/usr/bin/env bash

# Check if a release already exists for the given version
# Prevents duplicate releases

set -e

VERSION="${1:?Version required}"

# Check if release exists on GitHub
if gh release view "$VERSION" >/dev/null 2>&1; then
    echo "exists=true" >> "$GITHUB_OUTPUT"
    echo "Release $VERSION already exists"
    exit 0
else
    echo "exists=false" >> "$GITHUB_OUTPUT"
    echo "Release $VERSION does not exist - creating new release"
    exit 0
fi
