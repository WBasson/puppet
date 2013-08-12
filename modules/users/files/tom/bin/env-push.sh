#!/usr/bin/env zsh

# Abort if no parameter given
[ ${#@[@]} -eq 0 ] && { echo "No hostname specified" >&2; exit 1 }

# Determine SSH host/IP from final parameter and build ssh arguments
HOST_SPEC=$@[-1]
SSH_HOST="${HOST_SPEC##*@}"
SSH_ARGS="${@%$HOST_SPEC}"

# Parameters for setup of remote environment
REMOTE_USER=tom.b
REMOTE_GROUP=staff
REMOTE_DIR="/home/$REMOTE_USER"
PUPPET_DIR="$REMOTE_DIR/puppet"
PUPPET_REPO_R="https://github.com/tombamford/puppet.git"
PUPPET_REPO_W="ssh://github-with-hetz-key/tombamford/puppet.git"
PUPPET_MANIFEST="workstation"
PUPPETHETZ_DIR="$REMOTE_DIR/hetz/puppet"
PUPPETHETZ_REPO="tom.b@vcs.hetzner.co.za:/srv/git/puppet.git"

echo "Qualifying hostname..."
SSH_HOST=$(hetz-qualify-hostname.sh $SSH_HOST)

echo "Checking hostname..."
if ! host $SSH_HOST 2>/dev/null 1>/dev/null; then
  echo "Host not found!" >&2
  exit 1
fi

ssh_command() {
  ssh -q $=SSH_ARGS $SSH_HOST "$1"
}

echo "Making directories and copying ssh key ..."
ssh_command "mkdir -p $REMOTE_DIR/.ssh/keys $REMOTE_DIR/hetz && \
             chown -R $REMOTE_USER:$REMOTE_GROUP $REMOTE_DIR"
scp $HOME/.ssh/keys/tom.bamford@hetzner.co.za.key{,.pub} $SSH_HOST:$REMOTE_DIR/.ssh/keys
ssh_command "chown -R $REMOTE_USER:$REMOTE_GROUP $REMOTE_DIR/.ssh/keys/"

echo "Checking for existing tombamford/puppet repo clone ..."
if ! ssh $=SSH_ARGS $SSH_HOST "ls -d $PUPPET_DIR/.git 2>/dev/null 1>/dev/null"; then
  echo "Cloning tombamford/puppet into $PUPPET_DIR ..."
  ssh_command "cd $REMOTE_DIR && sudo -H -u $REMOTE_USER git clone $PUPPET_REPO_R $PUPPET_DIR"
else
  echo "Updating refs and pulling master branch of tombamford/puppet ..."
  ssh_command "cd $PUPPET_DIR && sudo -H -u $REMOTE_USER git fetch && \
               sudo -H -u $REMOTE_USER git checkout master && sudo -H -u $REMOTE_USER git pull origin master"
fi

echo "Setting push url for tombamford/puppet repo ..."
ssh_command "cd $PUPPET_DIR && sudo -H -u $REMOTE_USER git remote set-url --push origin $PUPPET_REPO_W"

echo "Performing puppet run using '$PUPPET_MANIFEST' manifest ..."
ssh_command "cd $PUPPET_DIR && sudo -H -u $REMOTE_USER ./submodules.sh && \
             $PUPPET_DIR/apply.sh $PUPPET_MANIFEST && \
             chown -R $REMOTE_USER:$REMOTE_GROUP $PUPPET_DIR"

echo "Checking for existing hetzner/puppet repo clone ..."
if ! ssh $=SSH_ARGS $SSH_HOST "ls -d $PUPPETHETZ_DIR/.git 2>/dev/null 1>/dev/null"; then
  echo "Cloning hetzer/puppet repo into $PUPPETHETZ_DIR ..."
  ssh_command "cd $REMOTE_DIR && sudo -H -u $REMOTE_USER git clone $PUPPETHETZ_REPO $PUPPETHETZ_DIR"
else
  echo "Updating refs and pulling master branch of hetz/puppet ..."
  ssh_command "cd $PUPPETHETZ_DIR && sudo -H -u $REMOTE_USER git fetch && \
               sudo -H -u $REMOTE_USER git checkout master && sudo -H -u $REMOTE_USER git pull origin master"
fi

echo "Copying required files ..."
ssh_command "cp -f /etc/hos_server $PUPPETHETZ_DIR/modules/hetzner/files/usr/local/hetzner/etc/hos_server && \
             cp -f /usr/local/hetzner/etc/staff_to_manage $PUPPETHETZ_DIR/modules/common/files/usr/local/hetzner/etc/staff_to_manage && \
             cp -f /home/ad/.k5login $PUPPETHETZ_DIR/modules/common/files/home/ad/.k5login && \
             chown $REMOTE_USER:$REMOTE_GROUP $PUPPETHETZ_DIR/modules/hetzner/files/usr/local/hetzner/etc/hos_server \
                                              $PUPPETHETZ_DIR/modules/common/files/usr/local/hetzner/etc/staff_to_manage \
                                              $PUPPETHETZ_DIR/modules/common/files/home/ad/.k5login"

echo "Done!"
