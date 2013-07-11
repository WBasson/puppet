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
      'gcc-c++',
      'readline-devel',
      'zlib-devel',
      'libyaml-devel',
      'libffi-devel',
      'openssl-devel',
      'autoconf',
      'automake',
      'libtool',
      'bison'
    ],
  }

  package { $packages:
    ensure => installed,
  }

}
