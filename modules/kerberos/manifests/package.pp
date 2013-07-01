class kerberos::package {

  package { 'krb5-workstation':
    ensure => installed,
  }

}
