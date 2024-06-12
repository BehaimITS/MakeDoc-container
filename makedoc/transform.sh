#!/bin/bash

# Default input and output file paths
input_path=${1:-index.md}
output_path=${2:-mkdocs.yml}

# Function to transform a line
transform_line() {
    local line=$1
    line=$(echo "$line" | sed 's/\[\(.*\)\](\(.*\))/\1: \2/')  # Replace [text](link) with text: link
    echo "$line"
}

# Function to calculate indent length
calculate_indent_length() {
    local line="$1"
    echo $(echo "$line" | sed -e 's/[^ \t].*//' | wc -c)
}

# Read input file and transform lines
{
    echo 'site_name: "bwce-integration-flow"'
    echo 'site_description: "This integrates everything with everything"'
    echo ''
    echo '# docs_dir: ./'
    echo ''
    echo 'nav:'

    # Initialize previous_line and previous_indent_length
    previous_line=""
    previous_indent_length=0

    while IFS= read -r current_line || [ -n "$current_line" ]; do
        if [[ -n "$current_line" && ! "$current_line" =~ ^# ]]; then
            current_indent_length=$(calculate_indent_length "$current_line")

            # Check if previous_line exists to process it
            if [[ -n "$previous_line" ]]; then
                indent=""
                for (( i=2; i<previous_indent_length; i+=4 )); do
                    indent="$indent  "
                done

                if [[ $previous_indent_length -lt $current_indent_length ]]; then
                    transformed_line=$(echo "$previous_line" | sed 's/\[\(.*\)\](\(.*\))/\1:/')
                else
                    transformed_line=$(transform_line "$previous_line")
                fi

                echo "${indent}$transformed_line"
            fi

            # Update previous_line and previous_indent_length
            previous_line="$current_line"
            previous_indent_length="$current_indent_length"
        fi
    done < "$input_path"

    # Handle the last line if any
    if [[ -n "$previous_line" && ! "$previous_line" =~ ^# ]]; then
        indent=""
        for (( i=2; i<previous_indent_length; i+=4 )); do
            indent="$indent  "
        done

        transformed_line=$(transform_line "$previous_line")
        echo "${indent}$transformed_line"
    fi
} > "$output_path"

echo "File transformed and saved to $output_path"
