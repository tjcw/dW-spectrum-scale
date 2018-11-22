#!/bin/bash -x
. ./set_hosts.sh
PATH=/usr/lpp/mmfs/bin:$PATH

function onall
{
  for host in ${hosts}
  do ssh ${host} "$@" </dev/null &
  done
  wait
}
onall lvcreate -L 1024G -n tjcwlv bb

for host in ${hosts}
do
  nsd=$(echo ${host}|tr '-' '_'|tr '.' '_')
  devline=$(ssh ${host} ls -l /dev/bb/tjcwlv </dev/null)
  dm=$(echo $devline|awk ' { print substr($11,4); }')
  echo "%nsd: device=/dev/${dm}"
  echo "      nsd=nsd_${nsd}"
  echo "      servers=${host}"
  echo "      usage=dataAndMetadata"
  echo "      failureGroup=-1"
  echo "      pool=system"
done >nsdfile
mmcrnsd -F nsdfile -v no
sleep 1
mmcrfs ssdfilesys \
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
while [[ $? -ne 0 ]]
do
  sleep 1
  mmcrfs ssdfilesys \
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
done       

mmmount  ssdfilesys -N c699launch01-ib0.c699.net,$(echo ${hosts}|tr ' ' ',')
mkdir /gpfs/ssdfilesys/tjcw
chown tjcw /gpfs/ssdfilesys/tjcw
