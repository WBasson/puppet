define ssl::cacert() {

  include ssl::package

  $cacert_dir = $::operatingsystem ? {
    'Debian' => '/usr/local/share/ca-certificates',
    'Fedora' => '/etc/pki/tls/certs',
  }

  if $::operatingsystem == 'Debian' {
    exec { 'update-ca-certificates':
      refreshonly => true,
      subscribe   => File["cacert-${name}"],
    }
  }

  file { "cacert-${name}":
    ensure  => present,
    path    => "${cacert_dir}/${name}.crt",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///modules/ssl/cacerts/${name}.crt",
    require => Class['ssl::package'],
  }

}
