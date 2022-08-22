#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Onjuist aantal parameters, geef volgende twee parameters op: input_start input_end"
    exit 1
fi

# slightly malformed input data
input_start=$(date '+%Y-%m-%d' -d "$1")
input_end=$(date '+%Y-%m-%d' -d "$2")

# After this, startdate and enddate will be valid ISO 8601 dates,
# or the script will have aborted when it encountered unparseable data
# such as input_end=abcd
startdate=$(date -I -d "$input_start") || exit -1
enddate=$(date -I -d "$input_end")     || exit -1

d="$startdate"
while [ "$(date -d "$d" +%Y%m%d)" -le "$(date -d "$enddate" +%Y%m%d)" ]; do
  d1=$(date '+%Y-%m-%d' -d "$d+1 days")
  echo "$d - $d1"
  ./getprices.sh $d $d1
  d=$(date -I -d "$d + 1 day")
done
