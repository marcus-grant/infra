#!/bin/bash

# Load env file
env_file=${1:-"/opt/restic-postgres/.env"}
if [ -f "$env_file" ]; then
    source "$env_file"
else
    echo "Error: Environment file $env_file not found."
    exit 1
fi

# PostgreSQL credentials
PGUSER=$RESTIC_PSQL_PGUSER
PGPASSWORD=$RESTIC_PSQL_PGPASSWORD
PGHOST=$RESTIC_PSQL_PGHOST

# Export Restic Environment Variables
export B2_ACCOUNT_ID=$RESTIC_PSQL_B2_ACCOUNT_ID
export B2_ACCOUNT_KEY=$RESTIC_PSQL_B2_ACCOUNT_KEY
export RESTIC_REPOSITORY=$RESTIC_PSQL_REPOSITORY
export RESTIC_PASSWORD=$RESTIC_PSQL_PASSWORD

# Check mandatory variables
for var in PGUSER PGPASSWORD PGHOST B2_ACCOUNT_ID B2_ACCOUNT_KEY RESTIC_REPOSITORY RESTIC_PASSWORD; do
    if [ -z "${!var}" ]; then
        echo "Error: $var is not set."
        exit 1
    fi
done

# Init repository if "init" flag is passed
if [ "$2" == "init" ]; then
    echo "Initializing restic repository"
    restic init
    exit 0
fi

# Generate filename using hostname and timestamp
TIMESTAMP=$(date -u +"%Y%m%dT%H%M%SZ")
HOSTNAME=$RESTIC_PSQL_MACHINE_HOSTNAME
FILENAME="${HOSTNAME}-postgres-dump-all.sql"

# Command to dump POSTGRESQL cluster & pipe to restic
PGPASSWORD=$PGPASSWORD pg_dumpall \
    -h $PGHOST \
    -U $PGUSER \
    | restic backup \
        --stdin \
        --stdin-filename $FILENAME

# Automatic Snapshot Pruning

echo "Pruning restic snapshots"

# Keep the last n snapshots
if [ -n "$RESTIC_PSQL_KEEP_LAST" ]; then
    restic forget --keep-last $RESTIC_PSQL_KEEP_LAST --prune
fi

# Keep n daily snapshots
if [ -n "$RESTIC_PSQL_KEEP_DAILY" ]; then
    restic forget --keep-daily $RESTIC_PSQL_KEEP_DAILY --prune
fi

# Keep n weekly snapshots
if [ -n "$RESTIC_PSQL_KEEP_WEEKLY" ]; then
    restic forget --keep-weekly $RESTIC_PSQL_KEEP_WEEKLY --prune
fi

# Keep n monthly snapshots
if [ -n "$RESTIC_PSQL_KEEP_MONTHLY" ]; then
    restic forget --keep-monthly $RESTIC_PSQL_KEEP_MONTHLY --prune
fi

# Keep n yearly snapshots
if [ -n "$RESTIC_PSQL_KEEP_YEARLY" ]; then
    restic forget --keep-yearly $RESTIC_PSQL_KEEP_YEARLY --prune
fi