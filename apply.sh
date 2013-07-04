#!/bin/sh

DIR="$(cd "$(dirname "$0")" && pwd)"
PWD="$(pwd)"; cd "$DIR"
git submodule status | egrep -q '^-[0-9a-zA-Z]+' && git submodule update --init
sudo puppet apply --modulepath "$DIR/modules" "$DIR/manifests/workstation.pp"
cd "$PWD"
