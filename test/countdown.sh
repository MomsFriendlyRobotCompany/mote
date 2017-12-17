#!/usr/bin/env bash

function countdown(){
  # calc stop time
   date1=$((`date +%s` + $1));
   while [ "${date1}" -ge `date +%s` ]; do
     # echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     echo -ne "."
     sleep 1
   done
   echo ""
}

echo "exiting in $1"
countdown $1
echo "bye"
