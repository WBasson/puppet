class vagrant {

  if $::operatingsystem == 'Fedora' {
    exec { 'install-vagrant':
      command => 'yum install -y http://files.vagrantup.com/packages/95d308caaecd139b8f62e41e7add0ec3f8ae3bd1/vagrant_1.2.3_x86_64.rpm',
      unless  => 'rpm -q vagrant-1.2.3',
    }
  }

}
