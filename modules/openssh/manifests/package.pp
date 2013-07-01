class openssh::package {

  package { [ 'openssh-clients', 'openssh-server' ]:
    ensure => installed,
  }

}
