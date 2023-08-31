#!/bin/bash

$RD_DIR="{{ restic_docker_dir }}"

# Display usage message
usage() {
    echo "Usage: $0 [-h|--help] [CONTAINER_NAMES ...]"
    echo "  -h, --help         Display this help message"
    echo "  CONTAINER_NAMES    Specify containers to stop"
    echo
    echo "This script stops Docker containers with named volumes."
    echo "It uses 'restic-docker-containers.sh' to identify containers."
    exit 1
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

# Get the list of containers with named volumes
containers_to_stop=($($RD_DIR/restic-docker-containers.sh))

# Append any additional container names from arguments
for arg in "$@"; do
    if [[ ! " ${containers_to_stop[@]} " =~ " ${arg} " ]]; then
        containers_to_stop+=("$arg")
    fi
done

# Initialize a flag to track if any containers failed to stop
stop_failed=false

# Stop each container and print the name if successful
for container_to_stop in "${containers_to_stop[@]}"; do
    if ! docker stop "$container_to_stop" > /dev/null 2>&1; then
        echo "Error stopping container: $container_to_stop"
        stop_failed=true
    else
	echo $container_to_stop
    fi
done

# If any containers failed to stop, exit with an error code
if [ "$stop_failed" = true ]; then
    exit 1
fi

