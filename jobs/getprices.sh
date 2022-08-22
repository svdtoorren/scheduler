#!/bin/bash

if [ -z "$1" ]
then
      startDate=$(date '+%Y-%m-%d')
else
      startDate=$(date '+%Y-%m-%d' -d "$1")
fi
startDate=$(date '+%Y-%m-%d' -d "$1")
endDate=$(date '+%Y-%m-%d' -d "$startDate+1 days")

# echo "Vandaag: $startDate"
# echo "Morgen: $endDate"

curl --location --request POST 'https://frank-api.nl/graphql' --header 'Content-Type: application/json' --data-raw '{"query":"query MarketPrices($startDate: Date!, $endDate: Date!) {   \n    marketPricesElectricity(startDate: $startDate, endDate: $endDate) \n        {\n            from\n            till\n            marketPrice\n            marketPriceTax\n            sourcingMarkupPrice\n            energyTaxPrice  \n        }\n    marketPricesGas(startDate: $startDate, endDate: $endDate) \n        {\n            from\n            till\n            marketPrice\n            marketPriceTax\n            sourcingMarkupPrice\n            energyTaxPrice  \n        }\n    }","variables":{"startDate":"'$startDate'","endDate":"'$endDate'"}}' | python -m json.tool > ./history/$startDate.json
