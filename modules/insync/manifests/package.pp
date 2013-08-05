class insync::package {

  include insync::repository

  package { [ 'insync-beta', 'insync-beta-kde' ]:
    ensure  => absent,
    require => Class['insync::repository'],
  }

  package { [ 'insync', 'insync-dolphin' ]:
    ensure  => installed,
    require => Class['insync::repository'],
  }

}
