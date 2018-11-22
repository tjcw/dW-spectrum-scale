#!/bin/bash -x
. ./set_hosts.sh
PATH=/usr/lpp/mmfs/bin:$PATH
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
