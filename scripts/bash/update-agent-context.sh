#!/usr/bin/env bash

# Update agent context based on project state
# Maintains agent-specific knowledge and project decisions

set -e

PROJECT_ROOT="${1:-.}"
AGENT_TYPE="${2:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

log_info "Updating agent context for project: $PROJECT_ROOT"

# Check if project exists
if [ ! -d "$PROJECT_ROOT/.agents" ]; then
  log_error "Project directory not found: $PROJECT_ROOT"
  exit 1
fi

# Find all agent-specific context files
update_agent_file() {
  local file="$1"
  local agent_name="$2"
  
  if [ ! -f "$file" ]; then
    log_warning "Agent file not found: $file"
    return 0
  fi
  
  log_info "Updating context for: $agent_name"
  
  # Update timestamp
  sed -i "s/Last updated:.*/Last updated: $(date)/" "$file" 2>/dev/null || true
  
  log_success "Updated: $agent_name"
}

# Update all agent context files
if [ -z "$AGENT_TYPE" ]; then
  # Update all agents
  log_info "Updating all agent contexts..."
  
  for agent_file in "$PROJECT_ROOT"/.agents/context/*.md; do
    if [ -f "$agent_file" ]; then
      agent_name=$(basename "$agent_file" .md)
      update_agent_file "$agent_file" "$agent_name"
    fi
  done
else
  # Update specific agent
  agent_file="$PROJECT_ROOT/.agents/context/${AGENT_TYPE}.md"
  update_agent_file "$agent_file" "$AGENT_TYPE"
fi

log_success "Agent context updated"

# Read project state
if [ -f "$PROJECT_ROOT/.agents/context/state.json" ]; then
  log_info "Current project phase: $(grep -o '"phase": "[^"]*"' "$PROJECT_ROOT/.agents/context/state.json" | cut -d'"' -f4)"
fi
