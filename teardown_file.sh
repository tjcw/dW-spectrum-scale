#!/bin/bash -x
. ./set_hosts.sh
function to_nsds
{  
  for host
  do
    echo "nsd_${host}"
  done
}
PATH=/usr/lpp/mmfs/bin:$PATH
mmumount ramfilesys -a
mmdelfs ramfilesys -p
allnsds=$(to_nsds ${hosts}|tr '-' '_'|tr '.' '_'|tr ' ' ',')
mmdelnsd "${allnsds}"

for host in ${hosts}
do
  ssh ${host} rm /tmp/nsdtmp </dev/null &
done
wait
