class insync::package {

  include insync::repository

  package { [ 'insync-beta', 'insync-beta-kde' ]:
    ensure  => installed,
    require => Class['insync::repository'],
  }

}
