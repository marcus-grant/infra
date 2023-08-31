#!/bin/bash

# Display usage message
usage() {
    echo "Usage: $0 CONTAINER_NAME"
    echo "  CONTAINER_NAME   Name of the container to retrieve volumes for"
    echo "Description:"
    echo "  This script will retrieve the volumes associated with"
    echo "  a Docker container."
    exit 2
}

# Check for required argument
if [[ -z "$1" ]]; then
    usage
fi

# Get the volumes associated with the container
{% raw %}
volumes=$(docker inspect -f "{{range .Mounts}}{{.Source}} {{end}}" "$1")
{% endraw %}

# Process and print each volume name associated with the container
for volume_path in $volumes; do
	volume_name=$(dirname "$volume_path" | awk -F'/' '{print $NF}')
	echo $volume_name
done
