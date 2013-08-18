class yum::config {

  if $::operatingsystem == 'Fedora' {

    file { '/etc/yum.conf':
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/yum/yum.conf',
    }

  }

}
