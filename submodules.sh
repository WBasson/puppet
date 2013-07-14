#!/bin/sh

# Determine correct directory and change into it
DIR="$(cd "$(dirname "$0")" && pwd)"
PWD="$(pwd)"; cd "$DIR"

# Initialise git submodules
git submodule status | egrep -q '^-[0-9a-zA-Z]+' && git submodule update --init

# Change directory to where we were
#cd "$PWD"
