#!/bin/bash

# Load env file
env_file="{{ restic_postgres_dir }}/restic-postgres.env"
if [ -f "$env_file" ]; then
    source "$env_file"
else
    echo "Error: Environment file $env_file not found."
    exit 1
fi

# Map custom environment variables to the ones expected by Restic and PostgreSQL
export B2_ACCOUNT_ID=$RESTIC_PSQL_B2_ACCOUNT_ID
export B2_ACCOUNT_KEY=$RESTIC_PSQL_B2_ACCOUNT_KEY
export RESTIC_REPOSITORY=$RESTIC_PSQL_REPOSITORY
export RESTIC_PASSWORD=$RESTIC_PSQL_PASSWORD

# Run restic command with arguments
restic "$@"
