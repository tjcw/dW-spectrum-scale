#!/bin/bash -x
. ./set_hosts.sh
PATH=/usr/lpp/mmfs/bin:$PATH
mmchlicense server --accept -N $(echo ${hosts}|tr ' ' ',')
