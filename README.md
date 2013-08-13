Workstation and home directory under Puppet control
===================================================

Fedora
------

    # rpm -ivh http://yum.puppetlabs.com/fedora/f18/products/i386/puppetlabs-release-18-7.noarch.rpm
    # yum install git puppet
    $ git clone git://github.com/tombamford/puppet.git ~/puppet
    $ ~/puppet/apply.sh

Debian
------

    # wget http://apt.puppetlabs.com/puppetlabs-release-`lsb_release -sc`.deb
    # apt-get update
    # apt-get install git puppet
    $ git clone git://github.com/tombamford/puppet.git ~/puppet
    $ ~/puppet/apply.sh

