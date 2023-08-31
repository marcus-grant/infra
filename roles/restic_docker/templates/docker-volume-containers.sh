#!/bin/bash
# Display usage message
usage() {
    echo "Usage: $0"
    echo "Description:"
    echo "    This script will retrieve the names of all Docker containers"
    echo "    that have volumes associated with them."
    exit 1
}

# Check for -h or --help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

# Get the list of all container names
{% raw %}
containers=$(docker ps -a --format "{{.Names}}")
{% endraw %}

# Initialize an array to store containers with volumes
containers_with_volumes=()

# Iterate through each container
for container in $containers; do
    {% raw %}
    docker_fmt="{{range .Mounts}}{{.Name}} {{end}}"
    {% endraw %}
    # Get the volumes associated with the container
    volumes=$(docker inspect -f "$docker_fmt" "$container")

    # If there are volumes associated with the container, add it to the array
    if [[ -n "$volumes" ]]; then
        containers_with_volumes+=("$container")
    fi
done

# Print the names of containers with volumes, one per line
for container_with_volumes in "${containers_with_volumes[@]}"; do
    echo "$container_with_volumes"
done
