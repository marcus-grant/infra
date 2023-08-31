#!/bin/bash
# Load env file
env_file="{{ restic_postgres_dir }}/.env"
if [ -f "$env_file" ]; then
    source "$env_file"
else
    echo "Error: Environment file $env_file not found."
    exit 1
fi

# Set PGPASSWORD environment variable
export PGPASSWORD=$RESTIC_PSQL_PGPASSWORD

# Get postgreSQL container IP address
postgres_ip=$({{ restic_postgres_dir }}/postgres-docker-ip.sh)
if [ -z "$postgres_ip" ]; then
    echo "Error: Could not determine postgreSQL container IP."
    exit 1
fi

# Use psql 
psql -U $RESTIC_PSQL_PGUSER -h $postgres_ip "$@"