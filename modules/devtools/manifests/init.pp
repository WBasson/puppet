class devtools {

  $packages = $::operatingsystem ? {
    'Debian' => [
      'build-essential',
    ],
    'Fedora' => [
      'autoconf',
      'automake',
      'bison',
      'gcc',
      'gcc-c++',
      'kernel-devel',
      'kernel-headers',
      'libffi-devel',
      'libtool',
      'libxml2-devel',
      'libxslt-devel',
      'libyaml-devel',
      'mysql-devel',
      'openssl-devel',
      'postgresql-devel',
      'qtwebkit-devel',
      'readline-devel',
      'zlib-devel',
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
