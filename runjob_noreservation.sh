#!/bin/bash -x
bsub -Is \
     -nnodes 16 \
     -q excl_int \
     -core_isolation 1 \
     -W 120 \
     /bin/bash
