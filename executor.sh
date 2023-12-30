#!/bin/bash

# Getting the working path
working_path="$WORKING_PATH"
log_file="executor.log"

# Reset log file
echo -n > "$log_file"

# Log function
log_message() {
    local log_text="$1"
    local current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

    # Log to console
    echo "[$current_datetime] $log_text"
    
    # Log to file
    echo "[$current_datetime] $log_text" >> "$log_file"
}

# Checking if working path is given
if [ -z "$working_path" ]; then
    log_message "Error: must have working path." >&2
    exit 1
fi

# Checking if working path is exist
if [ ! -e "$working_path" ]; then
    log_message "Error: working path $working_path not exist." >&2
    exit 1
fi

log_message "working on path: $working_path"

# Run scrips in working path
while true; do
    log_message "Waiting for script file..."

    # List all files and folders in the working path
    find "$working_path" -mindepth 1 -maxdepth 1 | while read -r entry; do
        if [ -d "$entry" ] || [ -f "$entry" ]; then

            # If it's not a shell script, delete it
            if [[ "$(file -b --mime-type "$entry")" != "text/x-shellscript" ]]; then
                log_message "Deleting non-shell file or folder: $entry"
                rm -r "$entry"
            else

                # If it's a shell script, run it
                log_message "Running shell script: $entry"
                output=$(bash "$entry")
                log_message "$output"
                log_message "Deleting shell file after running: $entry"
                rm "$entry"
            fi
        fi
    done

    # Sleep each iteration
    sleep 5
done
