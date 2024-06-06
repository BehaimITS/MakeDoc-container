#!/bin/bash

# Default input and output file paths
input_path=${1:-index.md}
output_path=${2:-mkdocs.yml}

# Function to transform a line
transform_line() {
    local line=$1
    line=$(echo $line | sed 's/^- *//')         # Remove leading list markers
    line=$(echo $line | sed 's/\[\(.*\)\](\(.*\))/\1: \2/')  # Replace [text](link) with text: link
    echo $line
}

# Read input file and transform lines
{
    echo 'site_name: "bwce-integration-flow"'
    echo 'site_description: "This integrates everything with everything"'
    echo ''
    echo '# docs_dir: ./'
    echo ''
    echo 'nav:'
    
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            indent_count=$(echo "$line" | sed -e 's/[^ ]//g' | wc -c)
            indent=""
            for (( i=2; i<indent_count; i+=4 )); do
                indent="$indent  "
            done
            echo "${indent}- $(transform_line "$line")"
        fi
    done < "$input_path"
} > "$output_path"

echo "File transformed and saved to $output_path"
