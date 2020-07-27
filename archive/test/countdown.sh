#!/usr/bin/env bash

# http://www.amp-what.com
# linux bash > 4.2 prints unicode
# printf "\U1f916 \n"
# echo -ne "\U1f916"
# robot face \U1f916
# hour glass \u23f3 different u
function countdown(){
  # calc stop time
   date1=$((`date +%s` + $1));
   while [ "${date1}" -ge `date +%s` ]; do
     # echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     # echo -ne "."
     echo -ne "\U1f916"
     sleep 1
   done
   echo ""
}

echo "exiting in $1"
countdown $1
echo "bye"
