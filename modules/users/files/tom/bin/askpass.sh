#!/bin/sh
export SSH_ASKPASS=$(which ssh-askpass)
for KEY in $HOME/.ssh/keys/*.key; do
  ssh-add $KEY </dev/null
done
