#!/bin/bash

file="status.txt"
services=("home" "cloud" "media" "blog" "me" "chat" "log" "git" "archive" "dev" "fandom")
down=()
dir="content/issues/"
file="down.md"
md_file="$dir$file"

# Loop through each service in the list
for service in "${services[@]}"; do
    echo "Checking if $service is up..."
    status="$(curl -o /dev/null -s -w "%{http_code}\n" "https://$service.octubre.be")"
    echo $status

    if [[ $status -ge 500 ]]; then # Server error
      down+=("$service")
    fi
done

# Check if the array is empty
if [ ${#down[@]} -ne 0 ]; then
    if [ -e "$md_file" ]; then # If file exists, remove
        rm $md_file
    fi

    echo "---" >> "$md_file"
    echo "title: Service(s) Down" >> "$md_file"
    echo "date: $(date '+%Y-%m-%d %H:%M:%S')" >> "$md_file"
    echo "resolved: false" >> "$md_file"
    echo "severity: down" >> "$md_file"
    echo "affected:" >> "$md_file"

    # Loop through each service in the list
    for service in "${down[@]}"; do
      echo "- ${service^}" >> "$md_file"
    done

    echo "section: issue" >> "$md_file"
    echo "---" >> "$md_file"
    echo "" >> "$md_file"
    echo "*Investigating* - We're aware of reports that users are experiencing connection issues. We're currently investigating them, and apologize for any inconvenience it may be causing you." >> "$md_file"
else
  if [ -e "$md_file" ]; then # If file exists
    # Rename old file
    new_md_file="$dir$(date '+%Y-%m-%d-%H_%M_%S')-$file.old"
    mv $md_file $new_md_file
  fi
fi
