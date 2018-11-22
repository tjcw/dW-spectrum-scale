#!/bin/bash
. ./set_hosts.sh
nnodes=$(echo ${hosts}|wc -w)
rsper=1
typeset -i nrs=${nnodes}*${rsper}
if [[ -d /gpfs/ssdfilesys/tjcw/ ]]
then
  tgtdir=/gpfs/ssdfilesys/tjcw/
else
  tgtdir=/gpfs/ramfilesys/tjcw/
fi
fsdf=$(df -BG ${tgtdir}|awk '{ if ( NR == 2 ) print ;}')
fssize=$(echo ${fsdf}|awk '{ print substr($2,1,length($2)-1);}')
typeset -i iorblk=${fssize}/${nnodes}/${rsper}*90/100

IOR=/gpfs/wscgpfs01/tjcw/workspace/IOR/src/C
set -x
time jsrun --rs_per_host ${rsper} --nrs ${nrs} -a 1 \
  ${IOR}/IOR -r -w -o ${tgtdir}/iorfile -b ${iorblk}G
