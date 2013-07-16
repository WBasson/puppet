class ldap::config {

  include ldap::package
  include ssl::cacerts

  $cacert_dir = $::operatingsystem ? {
    'Debian' => '/usr/local/share/ca-certificates',
    'Fedora' => '/etc/pki/tls/certs',
  }

  if $::location == 'hetzner' {
    file { $::operatingsystem ? {
      'Debian' => '/etc/ldap/ldap.conf',
      'Fedora' => '/etc/openldap/ldap.conf',
      }:
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('ldap/ldap.conf_hetzner.erb'),
      require => [ Class['ldap::package'], Class['ssl::cacerts'] ],
    }
  }

}
