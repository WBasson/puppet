class ldap::package {

  package { $::operatingsystem ? {
    'Debian' => 'ldaputils',
    'Fedora' => 'openldap-clients',
  }: ensure => installed }

  package { 'ldapvi': ensure => installed }

}
