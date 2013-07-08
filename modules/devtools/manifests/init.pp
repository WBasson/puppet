class devtools {

  $packages = $::operatingsystem ? {
    'Debian' => [
      'build-essential',
      'linux-headers'
    ],
    'Fedora' => [
      'gcc',
      'kernel-devel',
      'kernel-headers',
    ],
  }

  package { $packages:
    ensure => installed,
  }

}
