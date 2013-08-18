class mysql::service {

  service { $::operatingsystem ? {
    'Debian' => 'mysql',
    'Fedora' => 'mysqld',
    }: enable => false }

}
