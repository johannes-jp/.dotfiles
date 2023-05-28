#!/bin/bash

# TODO - a version of this that categorizes each quicknote in obsidian files and deletes the original

# Initialize an associative array to store the dates
declare -A dates

# Iterate over all .md files in the working directory
for file in *.md; do
    # Extract the date from the filename
    date=$(echo "$file" | cut -d'_' -f1)

    # Add the date to the associative array
    dates["$date"]=1
done

# Consolidate files with the same date
for date in "${!dates[@]}"; do
    # Create a consolidated file for the current date
    consolidated_file="${date}.md"

    # Remove the file if it already exists
    rm -f "$consolidated_file"

    # Iterate over all .md files with the current date
    for file in "${date}"*.md; do
        # Append the contents of the current file to the consolidated file
        cat "$file" >> "$consolidated_file"
        echo -e "---" >> "$consolidated_file"
    done
done
