#!/bin/bash

# Display usage message
usage() {
    echo "Usage: $0 [-h|--help]"
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message"
    echo
    echo "Description:"
    echo "  This script stops containers, performs a backup, and starts containers."
    echo "  Restic performs the backups related to variables stored in .env."
    echo "  It uses these related scripts and files:"
    echo "    * {{ restic_docker_dir }}/.env"
    echo "    * {{ restic_docker_dir }}/docker-volume-containers.sh"
    echo "    * {{ restic_docker_dir }}/restic-docker.sh"
    echo "    * {{ restic_docker_dir }}/restic-docker-stop.sh"
    echo "    * {{ restic_docker_dir }}/restic-docker-start.sh"
    echo "    * {{ restic_docker_dir }}/restic-docker-backup-cmd.sh"
    echo "    * {{ restic_docker_dir }}/restic-docker-containers.sh"
    echo
    exit 2
}


# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

# Function to handle errors and exit
handle_error() {
    echo "Error: $1"
    echo "Starting containers again..."
    {{ restic_docker_dir }}/restic-docker-start.sh
    exit 1
}

# Stop containers
_stop() {
    echo "Stopping containers..."
    if ! {{ restic_docker_dir }}/restic-docker-stop.sh; then
        handle_error "Failed to stop containers"
    fi
    echo
}

# Perform backup
_backup() {
    echo "Performing backup..."
    if ! {{ restic_docker_dir }}/restic-docker-backup-cmd.sh; then
        handle_error "Failed to perform backup"
    fi
    echo
}

# Start containers
_start() {
    echo "Starting containers..."
    if ! {{ restic_docker_dir }}/restic-docker-start.sh; then
        handle_error "Failed to start containers"
    fi
    echo
}

_stop
_backup
_start
echo "Backup up and reloaded containers successfully"
