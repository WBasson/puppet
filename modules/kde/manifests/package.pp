class kde::package {

  if $::operatingsystem == 'Debian' {
    package { 'kde-standard':
      ensure => installed,
    }
  }

}
