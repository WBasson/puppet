class virtualbox::package {

  include virtualbox::repository

  $package = $::operatingsystem ? {
    'Debian' => 'virtualbox-4.2',
    'Fedora' => 'VirtualBox-4.2',
    default  => 'virtualbox',
  }
  
  package { $package:
    ensure  => installed,
    require => Class['virtualbox::repository'],
  }

}
