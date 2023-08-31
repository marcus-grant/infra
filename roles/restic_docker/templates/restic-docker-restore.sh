#!/bin/bash

RD_DIR="{{ restic_docker_dir }}"

# Display usage message
usage() {
    echo "Usage: $0 [-h|--help] [SNAPSHOT_ID]"
    echo "Options:"
    echo "  -h, --help        Display this help message"
    echo "  SNAPSHOT_ID       Specify the snapshot ID to restore (default: 'latest')"
    echo "Description:"
    echo "  This stops containers, restic restores volumes & restarts them."
    echo "  It uses these scripts and files:"
    echo "    - $RD_DIR/.env"
    echo "    - $RD_DIR/restic-docker-stop.sh"
    echo "    - $RD_DIR/restic-docker-restore-cmd.sh"
    echo "    - $RD_DIR/restic-docker-start.sh"
    echo
    exit 2
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

# Initialize variables
snapshot_id="latest"

# Check for snapshot ID argument
if [[ ! -z "$1" ]]; then
    snapshot_id="$1"
fi

# Function to handle errors and exit
handle_error() {
    echo "Error: $1"
    echo "Starting containers again..."
    $RD_DIR/restic-docker-start.sh
    exit 1
}

# Stop containers
echo "Stopping containers..."
if ! $RD_DIR/restic-docker-stop.sh; then
    handle_error "Failed to stop containers"
fi

# Restore volumes using restic
echo "Restoring volumes..."
if ! $RD_DIR/restic-docker-restore-cmd.sh
    handle_error "Failed to restore volumes"
fi

# Start containers
echo "Starting containers..."
if ! $RD_DIR/restic-docker-start.sh; then
    handle_error "Failed to start containers"
fi

echo "Containers stopped, volumes restored & containers started successfully."
echo

