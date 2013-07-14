class openssh::package {

  $packages = $::operatingsystem ? {
    'Debian' => [ 'openssh-client', 'openssh-server' ],
    'Fedora' => [ 'openssh-clients', 'openssh-server' ],
  }

  package { $packages:
    ensure => installed,
  }

}
