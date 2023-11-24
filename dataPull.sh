#!/bin/bash
api_key="44CD512C-79C1-4A5F-A6E0-5814C1D2E0F1"
currentPath=$(pwd)
output_dir="${currentPath}/cryptoData/"
base_url="https://rest.coinapi.io/v1/exchangerate/"

if [ ! -d "${output_dir}" ]; then
  echo "De directory bestaat nog niet. Aan het aanmaken..."
  mkdir -p "${output_dir}"
  echo "De directory is aangemaakt: ${output_dir}"
fi
  
umask 022


get_data(){
  local endpoint_url="$1"
  local full_url="${base_url}${endpoint_url}"
  local tijd
  tijd=$(date +"%Y%m%d-%H%M%S")
  local data_file="${output_dir}data-${tijd}.json"
  local error_file="${output_dir}error-${tijd}.json"
  curl_pull(){
    curl "${full_url}" \
    --request GET \
    --header "X-CoinAPI-Key: ${api_key}" \
    > "${data_file}" 2> "${error_file}";
  }

    if curl_pull;then
      rm -f "${error_file}"
      echo "De dataset bevattend de exchange rate van ${endpoint_url} is opgehaald en opgeslagen in ${data_file}."
    else
      rm -f "${data_file}"
      echo "Er is een fout opgetreden bij de API-oproep."
      echo "Bekijk het foutbestand voor meer informatie: ${error_file}."
    fi
  sleep 1
}

get_data "BTC/EUR"
get_data "BTC/ETH"
get_data "ETH/EUR"