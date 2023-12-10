#!/bin/bash
input_dir="/home/jensd/pulledData/"
pad="/home/jensd/csvfiles"
if [ ! -d "${pad}" ]; then
    mkdir "${pad}"
fi


for json_file in "$input_dir"/*.json; do
    if jq -e 'has("asset_id_base") and has("asset_id_quote")' "$json_file" > /dev/null; then
        tijd=$(jq -r '.time' "$json_file")
        van=$(jq -r '.asset_id_base' "$json_file")
        naar=$(jq -r '.asset_id_quote' "$json_file")
        ER=$(jq -r '.rate' "$json_file")

        output_csv="${pad}/${van}_${naar}.csv"
        mv "${json_file}" "${json_file}.txt"
    
        if [ ! -s "$output_csv" ];then
            echo "Tijd,Van,Naar,Exchange Rate" > "$output_csv"
        fi
        echo "$tijd,$van,$naar,$ER" >> "$output_csv"
        else
        # Goudgegevens
        goud_tijd=$(jq -r '.timestamp' "$json_file")
        goud_prijs=$(jq -r '.price' "$json_file")

        output_csv="${pad}/gold.csv"
        mv "${json_file}" "${json_file}.txt"

        if [ ! -s "$output_csv" ]; then
            echo "Tijd,Prijs" > "$output_csv"
        fi
        echo "$goud_tijd,$goud_prijs" >> "$output_csv"
    fi
done

echo "Transformatie voltooid en opgeslagen in ${pad}."