#!/bin/sh
for K in $HOME/.ssh/keys/*.key; do
  ssh-add $K </dev/null
done
