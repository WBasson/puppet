class php::package {

  package { $::operatingsystem ? {
    'Debian' => [
      'php5-cgi',
      'php5-cli',
      'php5-xml',
    ],
    'Fedora' => [
      'php',
      'php-cli',
      'php-gd',
      'php-imap',
      'php-ldap',
      'php-mbstring',
      'php-mcrypt',
      'php-mysqlnd',
      'php-pdo',
      'php-pgsql',
      'php-process',
      'php-xml',
    ],
  }: ensure => installed }

}
