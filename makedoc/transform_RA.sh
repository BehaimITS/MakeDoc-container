#!/bin/bash

# Výchozí vstupní a výstupní cesty k souborům
input_path=${1:-index.md}
output_path=${2:-mkdocs.yml}

# Funkce pro transformaci řádku
transform_line() {
    local line=$1
    line=$(echo "$line" | sed -E 's|\[([^]]*/)?([^]/]+)\](\([^)]*\))|\[\2\]\3|; s|\[\](\([^)]*\))|\[default\](\1)|')
    line=$(echo "$line" | sed 's/\[\(.*\)\](\(.*\))/\1: \/ra\/\2/')  # Nahraď [text](link) text: /ra/link
    echo "$line"
}

# Funkce pro výpočet délky odsazení
calculate_indent_length() {
    local line="$1"
    echo $(echo "$line" | sed -e 's/[^ \t].*//' | wc -c)
}

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

    # Inicializace previous_line a previous_indent_length
    previous_line=""
    previous_indent_length=0

    first_line=true

    while IFS= read -r current_line || [ -n "$current_line" ]; do
        if [[ -n "$current_line" && ! "$current_line" =~ ^# ]]; then
            current_indent_length=$(calculate_indent_length "$current_line")

            # Zkontrolujte, zda existuje previous_line pro jeho zpracování
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

                # Zkontrolujte, zda je to první řádek, který připojujete
                if $first_line; then
                    echo ""  # Přidání prázdného řádku před prvním připojeným řádkem
                    transformed_line=$(echo "$transformed_line" | sed 's/Introduction:/Repository Analyst documentation:/')
                    transformed_line=$(echo "$transformed_line" | sed 's/: \/ra\/intro.md/:/')
                    first_line=false
                else
                    # Odsazení ostatních řádků
                    indent="      $indent"
                fi

                echo "${indent}$transformed_line"
            fi

            # Aktualizace previous_line a previous_indent_length
            previous_line="$current_line"
            previous_indent_length="$current_indent_length"
        fi
    done < "$input_path"

    # Zpracování posledního řádku, pokud existuje
    if [[ -n "$previous_line" && ! "$previous_line" =~ ^# ]]; then
        indent=""
        for (( i=2; i<previous_indent_length; i+=4 )); do
            indent="$indent  "
        done

        transformed_line=$(transform_line "$previous_line")

        # Zkontrolujte, zda je to první řádek, který připojujete
        if $first_line; then
            echo ""  # Přidání prázdného řádku před prvním připojeným řádkem
            transformed_line=$(echo "$transformed_line" | sed 's/Introduction:/Repository Analyst documentation:/')
            transformed_line=$(echo "$transformed_line" | sed 's/: \/ra\/intro.md/:/')
            first_line=false
        else
            # Odsazení ostatních řádků
            indent="  $indent"
        fi

        echo "${indent}$transformed_line"
    fi
} >> "$output_path"

echo "Soubor transformován a připojen k $output_path"
