class kerberos::package {

  package { $::operatingsystem ? {
    'Debian' => 'krb5-user',
    'Fedora' => 'krb5-workstation',
  }: ensure => installed, }

}
