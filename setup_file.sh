#!/bin/bash -x
. ./set_hosts.sh
PATH=/usr/lpp/mmfs/bin:$PATH
for host in ${hosts}
do
  ssh ${host} dd if=/dev/zero of=/tmp/nsdtmp bs=1G count=128 </dev/null &
done
wait

for host in ${hosts}
do
  nsd=$(echo ${host}|tr '-' '_'|tr '.' '_')
  echo "%nsd: device=/tmp/nsdtmp"
  echo "      nsd=nsd_${nsd}"
  echo "      servers=${host}"
  echo "      usage=dataAndMetadata"
  echo "      failureGroup=-1"
  echo "      pool=system"
done >nsdfile
mmcrnsd -F nsdfile -v no
sleep 10
mmcrfs ramfilesys \
       -F nsdfile \
       -A yes \
       -D posix \
       -E no \
       -j cluster \
       -k posix \
       -K no \
       -n $(echo ${hosts}|wc -w) \
       -S yes \
       --version=5.0.0.0

mmmount  ramfilesys -N c699launch01-ib0.c699.net,$(echo ${hosts}|tr ' ' ',')
mkdir /gpfs/ramfilesys/tjcw
chown tjcw /gpfs/ramfilesys/tjcw
