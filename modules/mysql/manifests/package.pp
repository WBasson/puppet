class mysql::package {

  case $::operatingsystem {
    'Debian': {
      package { ['mysql-client', 'mysql-server']: ensure => installed }
    }
    'Fedora': {
      if $::lsbdistrelease >= 19 {
        package { ['mariadb', 'mariadb-server']: ensure => installed }
      } else {        
        package { ['mysql', 'mysql-server']: ensure => installed }
      }
    }
  }

}
