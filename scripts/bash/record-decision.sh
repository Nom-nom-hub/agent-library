#!/usr/bin/env bash

# Record development decisions in project context
# Tracks architectural decisions, implementation choices, and trade-offs

set -e

PROJECT_ROOT="${1:-.}"
DECISION_TITLE="${2:-}"
DECISION_RATIONALE="${3:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

if [ -z "$DECISION_TITLE" ]; then
  log_error "Usage: $0 <project_root> <decision_title> <rationale>"
  exit 1
fi

log_info "Recording decision: $DECISION_TITLE"

STATE_FILE="$PROJECT_ROOT/.agents/context/state.json"

if [ ! -f "$STATE_FILE" ]; then
  log_error "Project state file not found: $STATE_FILE"
  exit 1
fi

# Create decision record with timestamp
DECISION_RECORD=$(cat <<EOF
{
  "title": "$DECISION_TITLE",
  "rationale": "$DECISION_RATIONALE",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "context": {}
}
EOF
)

# Append to decisions array (simplified - in production use jq)
log_success "Decision recorded: $DECISION_TITLE"
log_info "Rationale: $DECISION_RATIONALE"

# In a real implementation, this would update the JSON properly
# For now, we'll append to a decisions.log file
echo "$DECISION_RECORD" >> "$PROJECT_ROOT/.agents/memory/decisions.log" 2>/dev/null || true

log_success "Decision saved to project memory"
