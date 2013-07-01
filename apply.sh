#!/bin/sh

DIR="$(cd "$(dirname "$0")" && pwd)"
sudo puppet apply --modulepath "$DIR/modules" "$DIR/manifests/workstation.pp"
