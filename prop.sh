#!/bin/bash

if [ ! $1 ]; then
  echo "Going to need something to watch..."
  echo "Usage : $0 [FQDN] [TIMER]"
  exit
fi

fqdn=$(echo $1)
timer=5
serversFile=servers.txt

if [ $2 ]; then
  timer=$(echo $2)
fi

serversDNS=$(cat ${serversFile}|cut -d':' -f1)
serversTxt=$(cat ${serversFile}|cut -d':' -f2)

while [ 1 -ne 2 ]; do
  loop=0
  echo "Digging results : ${fqdn}"
  for server in ${serversDNS}; do
    output=$(dig @${server} +short ${fqdn})
    loop=$(expr ${loop} + 1)
    dnsoutput=$(echo ${serversTxt}|cut -d' ' -f${loop})
    echo "[${dnsoutput}]	${output}"
  done
  sleep ${timer} && clear
done
