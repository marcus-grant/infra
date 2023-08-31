#!/bin/bash

RD_DIR="{{ restic_docker_dir }}"

# Display usage message
usage() {
    echo "Usage: $0 [-h|--help] [restic arguments ...]"
    echo "Options:"
    echo "  -h, --help         Display this help message"
    echo "  restic arguments   Arguments to pass to the Restic command"
    echo "Description:"
    echo "  This script runs the Restic command with"
    echo "  environment variables from $RD_DIR/.env."
    echo "  This makes it easy to run Restic commands against"
    echo "  the same repository without having to specify"
    echo "  the repository, password, etc. each time."
    echo
    exit 2
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

# Load environment variables from .env file
if [[ -f "$RD_DIR/.env" ]]; then
    source "$RD_DIR/.env"
else
    echo "Error: $RD_DIR/.env file not found."
    exit 1
fi

# Set restic environment variables
export RESTIC_REPOSITORY="$RESTIC_DOCKER_RESTIC_REPOSITORY"
export B2_ACCOUNT_ID="$RESTIC_DOCKER_B2_ACCOUNT_ID"
export B2_ACCOUNT_KEY="$RESTIC_DOCKER_B2_ACCOUNT_KEY"
export RESTIC_PASSWORD="$RESTIC_DOCKER_RESTIC_PASSWORD"
export RESTIC_COMPRESSION="$RESTIC_DOCKER_RESTIC_COMPRESSION"

# Pass environment variables and script arguments to Restic command
restic "$@"

# Handle Restic exit code
_restic_rc=$?
if [[ $_restic_rc -ne 0 ]]; then
    echo "Error: $0 exited with code $_restic_rc"
    exit 1
fi
