class ldap::package {

  package { $::operatingsystem ? {
    'Debian' => 'ldap-utils',
    'Fedora' => 'openldap-clients',
  }: ensure => installed }

  package { 'ldapvi': ensure => installed }

}
