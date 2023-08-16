#!/bin/bash

# This script watches /etc/nginx/{conf.d,sites-enabled} for
# changes and reloads nginx if any files are detected to have changed.
# A timestamp is written to /tmp/nginx-reload-on-change.timestamp.
# This script is intended to be run from systemd timers.
# The script perfoms a stat on every file in the directories to watch and
# stores the latest mtime of any of the files in the watch list of directores.
# If the latest mtime is newer than the timestamp file, nginx is reloaded.
# End of comment tag

# Variables
DEFAULT_NGINX_TIMESTAMP_FILE="/tmp/nginx-reload-on-change.timestamp"
DEFAULT_NGINX_WATCHED_DIRS=(
{% for dir in nginx_reload_daemon_watched_dirs %}
"{{ dir }}"
{% endfor %}
)

# Functions
function main {
    $timestampFile=$DEFAULT_NGINX_TIMESTAMP_FILE
    $watchedDirs=$DEFAULT_NGINX_WATCHED_DIRS
    pastTimestamp=$(past-timestamp $timestampFile)
    maxMtime=$(max-mtime $watchedDirs)
    if [ "$pastTimestamp" -eq 1 ]; then
        echo "No timestamp file found. Creating one."
        update-timestamp $maxMtime
        reload-nginx
    elif [ "$maxMtime" -gt "$pastTimestamp" ]; then
        echo "Detected change in nginx config. Reloading nginx."
        update-timestamp $maxMtime
        reload-nginx
    fi
    exit 0
}

function past-timestamp {
    if [ ! -f "$1" ]; then
        echo "1"
        return 0
    fi
    # echo the unix timestamp within the file, trimming whitespace and
    # non-numeric characters
    echo $(cat "$1" | tr -d '[:space:]' | tr -d '[:alpha:]')
}

function max-mtime {
    
    watchedFiles=$(watched-files "$1")
    _maxMtime="0"
    for _file in "${watchedFiles[@]}"; do
        _mtime=$(stat -c %Y "$_file")
        if [ "$_mtime" -gt "$_maxMtime" ]; then
            _maxMtime="$_mtime"
        fi
    done
    echo "$_maxMtime"
}

function watched-files {
    local _files=()
    for dir in "${$1[@]}"; do
        for file in $(find "$dir" -type f); do
            _files+=("$file")
        done
    done
    if [ ${#_files[@]} -eq 0 ]; then
        echo "0"
        return 0
    fi
    echo "${_files[@]}"
}

function update-timestamp {
    # create timestamp of same format as found in mtime
    echo $(date +%s) > "$timestampFile"
}

function reload-nginx {
    systemctl reload nginx
}

main "$@"
