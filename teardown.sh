#!/bin/bash -x
. ./set_hosts.sh

function to_nsds
{  
  for host
  do
    echo "nsd_${host}"
  done
}
function onall
{
  for host in ${hosts}
  do ssh ${host} "$@" </dev/null &
  done
  wait
}

PATH=/usr/lpp/mmfs/bin:$PATH
mmumount ssdfilesys -a
mmdelfs ssdfilesys -p
allnsds=$(to_nsds ${hosts}|tr '-' '_'|tr '.' '_'|tr ' ' ',')
mmdelnsd "${allnsds}"
while [[ $? -ne 0 ]]
do
  sleep 1
  mmdelnsd "${allnsds}"
done

onall lvremove -y bb/tjcwlv
