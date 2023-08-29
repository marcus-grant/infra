#!/bin/bash

# Source env file
restic_postgres_env_file="{{ restic_postgres_dir }}/.env"
if [ -f "$restic_postgres_env_file" ]; then
    source "$restic_postgres_env_file"
else
    echo "Error: Environment file $restic_postgres_env_file not found."
    exit 1
fi

# Get IP of PostgreSQL container
ip=$(docker network inspect "$RESTIC_PSQL_DOCKER_NET" | \
     jq -r ".[0].Containers[] | \
     select(.Name == \"$RESTIC_PSQL_PGHOST\") | \
     .IPv4Address" | \
     cut -d/ -f1)

# Check if the IP was retrieved successfully
if [ $? -ne 0 ]; then
    echo "Error: Failed to get IP of PostgreSQL container."
    exit 2
fi

# Output IP
echo "$ip"
