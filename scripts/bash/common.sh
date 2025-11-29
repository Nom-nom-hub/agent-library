#!/usr/bin/env bash

# Common functions for Agent Library scripts

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ${NC} $*"
}

log_success() {
    echo -e "${GREEN}✓${NC} $*"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $*"
}

log_error() {
    echo -e "${RED}✗${NC} $*" >&2
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Run command with error handling
run_command() {
    local cmd="$@"
    log_info "Running: $cmd"
    if ! eval "$cmd"; then
        log_error "Command failed: $cmd"
        return 1
    fi
}

# Export for use in sourced scripts
export -f log_info log_success log_warning log_error command_exists run_command
