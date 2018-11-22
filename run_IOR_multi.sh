#!/bin/bash -x
. ./set_hosts.sh
nnodes=$(echo ${hosts}|wc -w)
if [[ -d /gpfs/ssdfilesys/tjcw/ ]]
then
  tgtdir=/gpfs/ssdfilesys/tjcw/
else
  tgtdir=/gpfs/ramfilesys/tjcw/
fi
fsdf=$(df -BG ${tgtdir}|awk '{ if ( NR == 2 ) print ;}')
fssize=$(echo ${fsdf}|awk '{ print substr($2,1,length($2)-1);}')

IOR=/gpfs/wscgpfs01/tjcw/workspace/IOR/src/C
for rsper in 2 4 8 16 32 40 1
do
  typeset -i nrs=${nnodes}*${rsper}
  typeset -i iorblk=${fssize}/${nnodes}/${rsper}*50/100
  echo "rsper=${rsper} nrs=${nrs}"
  time jsrun --rs_per_host ${rsper} --nrs ${nrs} -a 1 \
    ${IOR}/IOR -r -w -o ${tgtdir}/iorfile -b ${iorblk}G
done