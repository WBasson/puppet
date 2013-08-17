class kde::package {

  if $::operatingsystem == 'Debian' {
    package { 'kde-standard':
      ensure => installed,
    }
  }

  if $::operatingsystem == 'Fedora' {
    package { [ 'oxygen-cursor-themes', 'oxygen-icon-theme' ]:
      ensure => installed,
    }
  }

}
