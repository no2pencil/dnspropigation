#!/bin/bash

if [ ! $1 ]; then
  echo "Going to need something to watch..."
  echo "Usage : $0 [FQDN]"
  exit
fi

fqdn=$(echo $1)

servers="8.8.8.8 4.2.2.1 1.1.1.1"

while [ 1 -ne 2 ]; do
  loop=0
  for server in ${servers}; do
    output=$(dig @${server} +short ${fqdn})
    if [ ${loop} -eq 0 ]; then
      echo "Google : ${output}"
    fi
    if [ ${loop} -eq 1 ]; then
      echo "Verizon: ${output}"
    fi
    if [ ${loop} -eq 2 ]; then
      echo "CloudFlare: ${output}"
    fi
    loop=$(expr ${loop} + 1)
  done
  sleep 5 && clear
done
