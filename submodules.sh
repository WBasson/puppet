#!/bin/sh

# Determine correct directory and change into it
cd "$(cd "$(dirname "$0")" && pwd)"

# Initialise git submodules and return status code
if git submodule status | egrep -q '^-[0-9a-zA-Z]+'; then
  git submodule update --init
  exit $?
else
  exit 0
fi
