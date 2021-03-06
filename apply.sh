#!/bin/sh

# Determine correct directory and change into it
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

# Determine manifest to apply
if [ -n "$1" ]; then
  MANIFEST="$1"
else
  MANIFEST="workstation"
fi

# Some tasks are better left if we aren't the correct user
if [ $(id -u) -ne 0 ]; then

  # Initialise git submodules
  ./submodules.sh

  # Copy updated ssh/known_hosts back into repository and commit (if no other changes are staged)
  if [ "$MANIFEST" = "workstation" ]; then
    KNOWN_HOSTS_REAL="$HOME/.ssh/known_hosts"
    KNOWN_HOSTS_REPO="$DIR/modules/users/files/$USER/dotfiles/ssh/known_hosts"
    if [ -f "$KNOWN_HOSTS_REAL" ] && [ "$KNOWN_HOSTS_REAL" -nt "$KNOWN_HOSTS_REPO" ]; then
      SUM_REAL=$(md5sum "$KNOWN_HOSTS_REAL" | awk '{print $1;}')
      SUM_REPO=$(md5sum "$KNOWN_HOSTS_REPO" | awk '{print $1;}')
      if [ "$SUM_REPO" != "$SUM_REAL" ]; then
        cp -v "$KNOWN_HOSTS_REAL" "$KNOWN_HOSTS_REPO"
        if ! git status | grep -qc '^# Changes to be committed:$'; then
          git add "$KNOWN_HOSTS_REPO"
          git commit -m 'Update ssh/known_hosts'
        fi
      fi
    fi
  fi

fi

# Perform puppet run
[ $(id -u) -ne 0 ] && SUDO="sudo -H"
$SUDO puppet apply --color ansi --modulepath "$DIR/modules" "$DIR/manifests/$MANIFEST.pp"

# Exit with status code
exit $?
