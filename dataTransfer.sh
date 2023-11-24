#!/bin/bash
input_dir="/home/jensd/cryptoData/"
pad="/home/jensd/csvfiles"
if [ ! -d "${pad}" ]; then
    mkdir "${pad}"
fi


for json_file in "$input_dir"/*.json; do
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
done

echo "Transformatie voltooid en opgeslagen in ${pad}."