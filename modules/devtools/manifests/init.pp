class devtools {

  $packages = $::operatingsystem ? {
    'Debian' => [
      'build-essential',
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

  if $::operatingsystem == 'Debian' {
    exec { 'install-linux-headers':
      command  => 'apt-get install linux-headers-$(uname -r)',
      provider => 'shell',
      unless   => 'dpkg -l | grep linux-headers-$(uname -r) | grep -q "^ii"',
    }
  }

}
