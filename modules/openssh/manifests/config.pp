class openssh::config {

  file { '/etc/ssh/sshd_config':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('openssh/sshd_config.erb'),
    require => Class['openssh::package'],
    notify  => Class['openssh::service'],
  }

}
