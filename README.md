Workstation and home directory under Puppet control

# rpm -ivh http://yum.puppetlabs.com/fedora/f18/products/i386/puppetlabs-release-18-7.noarch.rpm
# yum install git puppet
$ mkdir ~/git
$ git clone git://github.com/tombamford/puppet.git ~/git/puppet
$ ~/git/puppet/apply.sh
