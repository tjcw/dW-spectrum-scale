#!/bin/bash -x
. ./set_hosts.sh
PATH=/usr/lpp/mmfs/bin:$PATH

mmchlicense client --accept -N $(echo ${hosts}|tr ' ' ',')