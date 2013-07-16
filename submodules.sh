#!/bin/sh

# Determine correct directory and change into it
cd "$(cd "$(dirname "$0")" && pwd)"

# Initialise git submodules
git submodule status | egrep -q '^-[0-9a-zA-Z]+' && git submodule update --init

# Exit with status code
exit $?
