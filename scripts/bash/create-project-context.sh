#!/usr/bin/env bash

# Create and initialize project context for Agent Library projects
# This script sets up the necessary context structure when a project is initialized

set -e

PROJECT_ROOT="${1:-.}"
PROJECT_NAME="${2:-project}"

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

log_info "Initializing project context for: $PROJECT_NAME"

# Create context directories
mkdir -p "$PROJECT_ROOT/.agents/context"
mkdir -p "$PROJECT_ROOT/.agents/personas"
mkdir -p "$PROJECT_ROOT/.agents/tasks"
mkdir -p "$PROJECT_ROOT/.agents/memory"

log_success "Created context directories"

# Create initial context file
cat > "$PROJECT_ROOT/.agents/context/state.json" <<EOF
{
  "project": {
    "name": "$PROJECT_NAME",
    "created": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "version": "0.1.0"
  },
  "phase": "initialization",
  "active_personas": [],
  "completed_tasks": [],
  "project_decisions": [],
  "files_created": {},
  "metadata": {}
}
EOF

log_success "Created context state file"

# Create personas registry
cat > "$PROJECT_ROOT/.agents/personas/registry.json" <<EOF
{
  "available_personas": [
    "architect",
    "implementer",
    "debugger",
    "reviewer",
    "researcher",
    "documentarian",
    "optimizer",
    "tester"
  ],
  "active_personas": [],
  "persona_sessions": {}
}
EOF

log_success "Created personas registry"

# Create tasks tracking file
cat > "$PROJECT_ROOT/.agents/tasks/tracking.json" <<EOF
{
  "tasks": [],
  "completed": [],
  "in_progress": [],
  "failed": []
}
EOF

log_success "Created tasks tracking"

# Create memory index
cat > "$PROJECT_ROOT/.agents/memory/index.md" <<EOF
# $PROJECT_NAME Memory Index

Project-specific knowledge and decisions.

## Key Decisions

_To be populated as development proceeds_

## Architecture Notes

_To be populated during planning phase_

## Implementation Notes

_To be populated during implementation_

## Lessons Learned

_To be populated throughout development_
EOF

log_success "Created memory index"

log_success "Project context initialized successfully!"

# Output JSON for programmatic use
if [ "$3" == "--json" ]; then
  cat <<EOF
{
  "status": "success",
  "project": "$PROJECT_NAME",
  "root": "$PROJECT_ROOT",
  "context_dir": "$PROJECT_ROOT/.agents/context",
  "personas_dir": "$PROJECT_ROOT/.agents/personas",
  "tasks_dir": "$PROJECT_ROOT/.agents/tasks",
  "memory_dir": "$PROJECT_ROOT/.agents/memory"
}
EOF
fi
