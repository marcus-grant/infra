#!/bin/bash

# Load env file
env_file="{{ restic_postgres_dir }}/.env"
if [ -f "$env_file" ]; then
    source "$env_file"
else
    echo "Error: Environment file $env_file not found."
    exit 1
fi

# Get PostgreSQL container IP address
postgres_ip=$({{ restic_postgres_dir }}/postgres-docker-ip.sh)
if [ -z "$postgres_ip" ]; then
    echo "Error: Could not determine PostgreSQL container IP."
    exit 1
fi

# Perform the database dump using pg_dumpall
PGPASSWORD=$RESTIC_PSQL_PGPASSWORD pg_dumpall \
    -h $postgres_ip \
    -U $RESTIC_PSQL_PGUSER
