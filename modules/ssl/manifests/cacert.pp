define ssl::cacert() {

  include ssl::package

  $cacert_dir = $::operatingsystem ? {
    'Debian' => '/usr/local/share/ca-certificates',
    'Fedora' => '/etc/pki/tls/certs',
  }

  if !defined(Exec['update-ca-certificates']) {
    exec { 'update-ca-certificates':
      refreshonly => true,
      command     => $::operatingsystem ? {
        'Debian' => 'update-ca-certificates',
        default  => 'true',
      },
    }
  }

  file { "cacert-${name}":
    ensure  => present,
    path    => "${cacert_dir}/${name}.crt",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///modules/ssl/cacerts/${name}.crt",
    notify  => Exec['update-ca-certificates'],
    require => Class['ssl::package'],
  }

}
