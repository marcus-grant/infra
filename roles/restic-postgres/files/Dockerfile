# Use Debian 12 as base image
FROM debian:12

# Install essential utilities, PostgreSQL client & restic
RUN apt-get update \
        && apt-get -y install curl wget jq \
        && apt-get -y install postgresql-client \
        && apt-get -y install restic

# Copy the backup script & env file into the container
COPY restic-postgres-backup.sh /restic-postgres-backup.sh
COPY restic-postgres.env /restic-postgres.env
RUN chmod +x /restic-postgres-backup.sh

# Run the backups script
CMD ["/restic-postgres-backup.sh"]
