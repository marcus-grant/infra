#!/bin/bash

RD_DIR="{{ restic_docker_dir }}"
RD_IGNORED_VOLUMES="backingFsBlockDev metadata.db var"
REAL_RESTORE_TARGET="/var/lib/docker/volumes"
TMP_RESTORE_ROOT="/tmp/var"
TMP_RESTORE_TARGET="${TMP_RESTORE_ROOT}/${REAL_RESTORE_TARGET}"
snapshot_id="latest"

if [ $# -ge 1 ]; then
	snapshot_id=$1
fi

# Call {{ restic_docker_dir }}/restic-docker.sh to restore
$RD_DIR/restic-docker.sh \
	restore "${snapshot_id}" \
	--host {{ restic_docker_host }} \
	--target {{ restic_docker_dir }}

# Check for volumes in restore target by checking for directory names
if [ ! -d "$TMP_RESTORE_TARGET" ]; then
	echo "Error: No volumes found in restore target."
	exit 1
fi
volumes=$(ls "$TMP_RESTORE_TARGET")

# Remove volumes to ignore
for volume in $RD_IGNORED_VOLUMES; do
	volumes=$(echo "$volumes" | sed "s/${volume}//g")
done

# Create docker volumes based on the volumes found in the restore target
for volume in $volumes; do
	docker volume create $volume
done

# Clean up the restore target
mv "$TMP_RESTORE_TARGET/*" $REAL_RESTORE_TARGET
rm -rf $TMP_RESTORE_ROOT
