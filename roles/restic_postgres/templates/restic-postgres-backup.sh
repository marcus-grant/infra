#!/bin/bash

# Load env file
env_file="{{ restic_postgres_dir }}/.env"
if [ -f "$env_file" ]; then
    source "$env_file"
else
    echo "Error: Environment file $env_file not found."
    exit 1
fi

# Generate the Postgres database dump and pipe it into restic for backup
{{ restic_postgres_dir }}/postgres-dumpall.sh \
    | {{ restic_postgres_dir }}/restic-postgres.sh backup \
        --host $RESTIC_PSQL_MACHINE_HOSTNAME \
        --compression $RESTIC_PSQL_COMPRESSION \
        --stdin --stdin-filename $RESTIC_PSQL_DUMP_FILENAME

# Prune old backups according to retention policies
{{ restic_postgres_dir }}/restic-postgres.sh forget \
    --keep-last $RESTIC_PSQL_KEEP_LAST \
    --keep-daily $RESTIC_PSQL_KEEP_DAILY \
    --keep-weekly $RESTIC_PSQL_KEEP_WEEKLY \
    --keep-monthly $RESTIC_PSQL_KEEP_MONTHLY \
    --keep-yearly $RESTIC_PSQL_KEEP_YEARLY \
    --prune
