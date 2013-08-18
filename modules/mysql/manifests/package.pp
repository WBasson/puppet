class mysql::package {

  package { $::operatingsystem ? {
    'Debian' => 'mysql-client',
    'Fedora' => 'mysql',
  }: ensure => installed }

  package { 'mysql-server': ensure => installed }

}
