#!/bin/bash

# The hostname to qualify
HOST="$1"

# List of datacentres for looking up unqualified hostnames
DATACENTRES=(dur1 tst1 cpt1 cpt2 cpt3 cpt4 jnb1 jnb2 flk1 nur4)

# Attempt to qualify hostname
for DC in ${DATACENTRES[@]}; do
  if [[ $HOST =~ ^.+\.$DC$ ]]; then
    HOST="$HOST.host-h.net"
    break
  fi
done

# Output hostname
echo $HOST
