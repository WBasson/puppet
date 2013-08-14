class openssh::service {

  service { 'openssh-server':
    enable  => true,
    ensure  => running,
    name    => $::operatingsystem ? {
      'Debian' => 'ssh',
      'Fedora' => 'sshd',
    },
    require => Class['openssh::package'],
  }

}
