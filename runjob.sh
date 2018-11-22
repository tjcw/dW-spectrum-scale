#!/bin/bash -x
. ./set_hosts.sh
bsub -Is \
     -nnodes $(echo ${hosts}|wc -w) \
     -q excl_int \
     -core_isolation 1 \
     -m "c699launch01 ${base_hosts}" \
     -U tjcw_1644 \
     -W 120 \
     /bin/bash
