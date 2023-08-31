#!/bin/bash

RD_DIR="{{ restic_docker_dir }}"

# Display usage message
usage() {
    echo "Usage: $0 [-h|--help] [CONTAINER_NAMES ...]"
    echo "  -h, --help         Display this help message"
    echo "  CONTAINER_NAMES    Specify additional containers to start"
    echo
    echo "This script starts Docker containers that"
    echo "have named volumes associated with them."
    echo "It uses these scripts and files:"
    echo "  - $RD_DIR/.env"
    echo "  - $RD_DIR/restic-docker-containers.sh"
    echo
    exit 1
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

# Get the list of containers with named volumes
containers_to_start=($($RD_DIR/restic-docker-containers.sh))

# Append any additional container names from arguments
for arg in "$@"; do
    if [[ ! " ${containers_to_start[@]} " =~ " ${arg} " ]]; then
        containers_to_start+=("$arg")
    fi
done

# Start each container and print the name if successful
for container_to_start in "${containers_to_start[@]}"; do
    if docker start "$container_to_start" > /dev/null 2>&1; then
        echo "$container_to_start"
    else
        echo "Error starting container: $container_to_start"
        exit 1
    fi
done

