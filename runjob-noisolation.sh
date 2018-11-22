#!/bin/bash -x
. ./set_hosts.sh
bsub -Is -nnodes $(echo ${hosts}|wc -w) -q excl_jitter_int -m "c699launch01 ${base_hosts}" /bin/bash
