#!/usr/bin/env bash

# Generate release notes from changelog and git history

set -e

NEW_VERSION="${1:?New version required}"
LATEST_TAG="${2:?Latest tag required}"

echo "Generating release notes for: $NEW_VERSION"

# Extract relevant section from CHANGELOG.md
if [ -f "CHANGELOG.md" ]; then
    echo "Extracting changelog for version: $NEW_VERSION"
    
    # Find the section for this version and extract it
    START_LINE=$(grep -n "## \[$NEW_VERSION\]" CHANGELOG.md | cut -d: -f1 || echo "0")
    
    if [ "$START_LINE" -gt 0 ]; then
        # Extract from this version to the next version header
        sed -n "${START_LINE},/^## \[/p" CHANGELOG.md | head -n -1 > /tmp/release_notes.tmp
        cat /tmp/release_notes.tmp
    else
        echo "No changelog entry found for $NEW_VERSION, using template"
        cat <<EOF
## [Unreleased]

### Added
- New features and enhancements

### Changed
- Breaking changes or significant modifications

### Fixed
- Bug fixes

### Security
- Security-related fixes

See [CHANGELOG.md](CHANGELOG.md) for complete history.
EOF
    fi
else
    echo "CHANGELOG.md not found, generating from git history"
    
    if [ "$LATEST_TAG" != "v0.0.0" ]; then
        git log "$LATEST_TAG"..HEAD --pretty=format:"- %s" || echo "- Release of version $NEW_VERSION"
    else
        echo "- Initial release"
    fi
fi

echo ""
echo "Release notes generated for: $NEW_VERSION"

# Output for GitHub Actions
echo "release_version=$NEW_VERSION" >> "$GITHUB_OUTPUT"
