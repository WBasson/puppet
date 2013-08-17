class kde::config {

  if $::operatingsystem == 'Debian' {
    file { '/etc/X11/default-display-manager':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "/usr/bin/kdm\n",
      require => Class['kde::package'],
    }
  }

}
