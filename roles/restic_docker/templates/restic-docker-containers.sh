#!/bin/bash

# Display usage message
usage() {
    echo "Usage: $0 [-h|--help] [CONTAINER_NAMES ...]"
    echo "Options:"
    echo "  -h, --help         Display this help message"
    echo "  CONTAINER_NAMES    Specify containers to exclude with spaces"
    echo "Description:"
    echo "  This script displays the list of containers with named volumes."
    echo "  Unlike the docker-volume-containers.sh script,"
    echo "  this script filters according to {{ restic_docker_dir }}/.env."
    echo "  CONTAINER_NAMES are containers to exclude from the list in the env."
    echo "  This allows for standardized filtering of containers with volumes."
    echo "Exit status:"
    echo "  1 - Error in script execution"
    echo "  2 - No containers to show after filtering"
    echo
    exit 1
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

# Source the environment variables
source "{{ restic_docker_dir }}/.env"

# Combine excluded containers from the environment and arguments
excluded_containers=("${RESTIC_DOCKER_EXCLUDED_CONTAINERS[@]}" "$@")

# Get the list of containers with named volumes
VOLUMES_CONTAINERS=$({{ restic_docker_dir }}/docker-volume-containers.sh)

# Initialize an array to store the filtered containers
filtered_containers=()

# Iterate through each container with named volumes
while IFS= read -r container_with_volume; do
    # Check if the container should be excluded from backup
    if [[ ! " ${excluded_containers[@]} " =~ " ${container_with_volume} " ]]; then
        filtered_containers+=("$container_with_volume")
    fi
done <<< "$VOLUMES_CONTAINERS"

# Print the list of filtered containers
for filtered_container in "${filtered_containers[@]}"; do
    echo "$filtered_container"
done
