#!/bin/bash

set -x

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$folder"/config

### OpenCoesione ###
dirOC="$folder/pubblicaAmministrazione/OpenCoesione"
mkdir -p "$dirOC"

rm "$dirOC"/opencoesione.zip
rm "$dirOC"/progetti.csv

# scarica i dati

curl -L "https://opencoesione.gov.it/it/progetti/csv/?q=&selected_facets=focus:beni_confiscati&selected_facets=is_pubblicato:true" >"$dirOC"/opencoesione.zip
unzip "$dirOC"/opencoesione.zip -d "$dirOC"
# scarica i metadati
curl -L "https://opencoesione.gov.it/media/opendata/metadati_progetti_tracciato_esteso.xls" >"$dirOC"/metadati_progetti_tracciato_esteso.xls

mlr -I --csv --ifs ";" --ofs "," clean-whitespace "$dirOC"/progetti.csv 
cp "$dirOC"/progetti.csv "$web"/opencoesione.csv
