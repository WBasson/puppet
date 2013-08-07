class dev::tools {

  package { $::operatingsystem ? {
    'Debian' => [
      'build-essential',
    ],
    'Fedora' => [
      'autoconf',
      'automake',
      'bison',
      'gcc',
      'gcc-c++',
      'libtool',
    ],
  }: ensure => installed }

}
