#!/bin/bash

# Výchozí vstupní a výstupní cesty k souborům
input_path=${1:-index.md}
output_path=${2:-mkdocs.yml}
temp_output_path="${output_path}.tmp"

# Funkce pro transformaci řádku
transform_line() {
    local line=$1
    line=$(echo "$line" | sed -E 's|\[([^]]*/)?([^]/]+)\](\([^)]*\))|\[\2\]\3|; s|\[\](\([^)]*\))|\[default\](\1)|')
    line=$(echo "$line" | sed 's/\[\(.*\)\](\(.*\))/\1: ra\/\2/')
    echo "$line"
}

# Funkce pro výpočet délky odsazení
calculate_indent_length() {
    local line="$1"
    echo $(echo "$line" | sed -e 's/[^ \t].*//' | wc -c)
}

# Smazání "Repository Analyst documentation"
if grep -q "Repository Analyst documentation:" "$output_path"; then
    # Použití sed k odstranění řádků od "Repository Analyst documentation:" včetně
    sed '/Repository Analyst documentation:/,$d' "$output_path" > "$temp_output_path"
    mv "$temp_output_path" "$output_path"
fi

# Připojení transformovaných řádků do výstupního souboru
{
    # Kontrola, zda výstupní soubor existuje a není prázdný
    if [[ ! -s "$output_path" ]]; then
        echo 'site_name: "bwce-integration-flow"'
        echo 'site_description: "This integrates everything with everything"'
        echo ''
        echo '# docs_dir: ./'
        echo ''
        echo 'nav:'
    fi

    echo '-   Repository Analyst documentation:'
    
    # Initialize previous_line and previous_indent_length
    previous_line=""
    previous_indent_length=0

    while IFS= read -r current_line || [ -n "$current_line" ]; do
        if [[ -n "$current_line" && ! "$current_line" =~ ^# ]]; then
            current_indent_length=$(calculate_indent_length "$current_line")

            # Check if previous_line exists to process it
            if [[ -n "$previous_line" ]]; then
                indent="      "  # Přidání základního odsazení pro všechny řádky kromě prvního
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

            # Transformace řádku
            transformed_line=$(transform_line "$current_line")

            # Update previous_line and previous_indent_length
            previous_line="$current_line"
            previous_indent_length="$current_indent_length"
        fi
    done < "$input_path"

    # Handle the last line if any
    if [[ -n "$previous_line" && ! "$previous_line" =~ ^# ]]; then
        indent="      "  # Přidání základního odsazení pro všechny řádky kromě prvního
        for (( i=2; i<previous_indent_length; i+=4 )); do
            indent="$indent  "
        done

        transformed_line=$(transform_line "$previous_line")
        echo "${indent}$transformed_line"
    fi

} >> "$output_path"

echo "Soubor transformován a připojen k $output_path"
