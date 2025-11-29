#!/usr/bin/env bash

# Check prerequisites for Agent Library projects
# Verifies that required tools are installed and accessible

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

log_info "Checking prerequisites for Agent Library..."

MISSING_TOOLS=0
OPTIONAL_TOOLS=0

# Define required tools
check_required() {
  local tool="$1"
  local description="$2"
  
  if command_exists "$tool"; then
    version=$("$tool" --version 2>/dev/null || echo "installed")
    log_success "Found: $description ($version)"
  else
    log_error "Missing: $description (required)"
    MISSING_TOOLS=$((MISSING_TOOLS + 1))
  fi
}

# Define optional tools
check_optional() {
  local tool="$1"
  local description="$2"
  
  if command_exists "$tool"; then
    version=$("$tool" --version 2>/dev/null || echo "installed")
    log_success "Found: $description ($version)"
  else
    log_warning "Not found: $description (optional)"
    OPTIONAL_TOOLS=$((OPTIONAL_TOOLS + 1))
  fi
}

echo ""
log_info "Required Tools:"
check_required "python" "Python 3.11+"
check_required "git" "Git version control"

echo ""
log_info "Optional Tools (AI Agents):"
check_optional "claude" "Claude Code CLI"
check_optional "gemini" "Gemini CLI"
check_optional "cursor-agent" "Cursor"
check_optional "amp" "Amp"
check_optional "qwen" "Qwen Code"

echo ""
if [ $MISSING_TOOLS -gt 0 ]; then
  log_error "$MISSING_TOOLS required tool(s) missing"
  exit 1
else
  log_success "All required tools are available"
fi

if [ $OPTIONAL_TOOLS -gt 0 ]; then
  log_warning "$OPTIONAL_TOOLS optional tool(s) not found"
  log_info "Consider installing at least one AI agent"
else
  log_success "All optional tools are available"
fi

log_success "Prerequisites check complete!"
