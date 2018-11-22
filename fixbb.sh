#!/bin/bash -x
. ./set_hosts.sh
function onall
{
  for host in ${hosts}
  do ssh ${host} "$@" </dev/null &
  done
  wait
}
onall vgremove bb
onall vgscan --cache
onall /opt/ibm/bb/scripts/bbactivate
