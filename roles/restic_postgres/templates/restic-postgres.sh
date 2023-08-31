#!/bin/bash

usage() {
    echo "Usage: $0 [restic_subcommands] [options]"
    echo "Description:"
    echo "  Wrapper script for restic to backup PostgreSQL database dumps."
    echo "  This script loads the environment variables from the .env file"
    echo "  with all the repository and password information."
    echo "  Run this command as if running restic wihtout repo or auth info."
    echo "Example:"
    echo "  $0 snapshots"
    echo
    exit 2
}

# Check for help flag
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    usage
fi

# Load env file
env_file="{{ restic_postgres_dir }}/.env"
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
export RESTIC_COMPRESSION=$RESTIC_PSQL_COMPRESSION

# Run restic command with arguments
restic "$@"
