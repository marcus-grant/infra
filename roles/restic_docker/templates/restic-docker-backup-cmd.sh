#!/bin/bash

# Display usage
usage() {
    echo "Usage: $0 [-h|--help]"
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message"
    echo
    echo "Description:"
    echo "  This script performs a backup of Docker volumes."
    echo "  Restic performs the backups related to variables stored in .env."
    echo "  It sets a standard set of parameters to backup Docker volumes."
    echo "  It uses these related scripts and files:"
    echo "    * {{ restic_docker_dir }}/.env"
    echo "    * {{ restic_docker_dir }}/restic-docker.sh"
    echo
    exit 2
}

# Call the standard restic-docker.sh script to perform the backup with restic
{{ restic_docker_dir }}/restic-docker.sh \
    backup /var/lib/docker/volumes \
    --host {{ restic_docker_host }} \
    --iexclude /var/lib/docker/volumes/backingFsBlockDev \
    --iexclude /var/lib/docker/volumes/metadata.db \
    --iexclude /var/lib/docker/volumes/var \
    -o b2.connections=20

# Check for errors
if [ $? -ne 0 ]; then
    echo "Error: Failed to perform backup with $0."
    exit 1
fi
