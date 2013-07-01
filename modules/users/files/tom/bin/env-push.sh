#!/usr/bin/env zsh

# Abort if no parameter given
[ ${#@[@]} -eq 0 ] && { echo "No hostname specified" >&2; exit 1 }

# Determine SSH host/IP from final parameter and build ssh arguments
HOST_SPEC=$@[-1]
SSH_HOST="${HOST_SPEC##*@}"
SSH_ARGS="${@%$HOST_SPEC}"

DOTFILES=$HOME/git/dotfiles
REMOTE_USER=tom.b
REMOTE_GROUP=staff
REMOTE_DIR=/home/$REMOTE_USER/git
PUPPET_DIR=$REMOTE_DIR/puppet
PUPPET_REPO="tom.b@vcs.hetzner.co.za:/srv/git/puppet.git"

echo "Qualifying hostname..."
SSH_HOST=$(hetz-qualify-hostname.sh $SSH_HOST)

echo "Checking hostname..."
if ! host $SSH_HOST 2>/dev/null 1>/dev/null; then
  echo "Host not found!" >&2
  exit 1
fi

#echo "Checking for rump installation ..."
#if ! ssh -q $=SSH_ARGS $SSH_HOST "[ -x /var/lib/gems/1.8/bin/rump ]"; then
#  echo "Installing rump from rubygems ..."
#  ssh -q $=SSH_ARGS $SSH_HOST "gem install rump --no-rdoc --no-ri && ln -s /var/lib/gems/1.8/bin/rump /usr/local/bin/rump"
#fi

echo "Making directories ..."
ssh -q $=SSH_ARGS $SSH_HOST "mkdir -p $REMOTE_DIR && chown -R $REMOTE_USER:$REMOTE_GROUP $REMOTE_DIR"

echo "Syncing dotfiles ..."
rsync -e "ssh $=SSH_ARGS" -aW $DOTFILES/ $SSH_HOST:$REMOTE_DIR/dotfiles
ssh -q $=SSH_ARGS $SSH_HOST "chown -R $REMOTE_USER:$REMOTE_GROUP $REMOTE_DIR/dotfiles"
ssh -q $=SSH_ARGS $SSH_HOST "cd /tmp && sudo -H -u $REMOTE_USER $REMOTE_DIR/dotfiles/install.sh -y"

echo "Checking for existing puppet repo clone ..."
if ! ssh $=SSH_ARGS $SSH_HOST "ls -d $PUPPET_DIR/.git 2>/dev/null 1>/dev/null"; then
  echo "Cloning puppet repo into $PUPPET_DIR ..."
  ssh -q $=SSH_ARGS $SSH_HOST "cd /tmp && sudo -H -u $REMOTE_USER git clone $PUPPET_REPO $PUPPET_DIR"
else
  echo "Updating refs and pulling master branch..."
  ssh -q $=SSH_ARGS $SSH_HOST "cd $PUPPET_DIR && sudo -H -u $REMOTE_USER git fetch"
  ssh -q $=SSH_ARGS $SSH_HOST "cd $PUPPET_DIR && sudo -H -u $REMOTE_USER git checkout master && sudo -H -u $REMOTE_USER git pull origin master"
fi

echo "Copying required files ..."
ssh -q $=SSH_ARGS $SSH_HOST cp -f /etc/hos_server $PUPPET_DIR/modules/hetzner/files/usr/local/hetzner/etc/hos_server
ssh -q $=SSH_ARGS $SSH_HOST cp -f /usr/local/hetzner/etc/staff_to_manage $PUPPET_DIR/modules/common/files/usr/local/hetzner/etc/staff_to_manage
ssh -q $=SSH_ARGS $SSH_HOST cp -f /home/ad/.k5login $PUPPET_DIR/modules/common/files/home/ad/.k5login
ssh -q $=SSH_ARGS $SSH_HOST chown $REMOTE_USER:$REMOTE_GROUP $PUPPET_DIR/modules/hetzner/files/usr/local/hetzner/etc/hos_server $PUPPET_DIR/modules/common/files/usr/local/hetzner/etc/staff_to_manage $PUPPET_DIR/modules/common/files/home/ad/.k5login

echo Done
