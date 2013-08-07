class dev::libs {

  package { $::operatingsystem ? {
    'Debian' => [
      'libsqlite3-dev',
      "linux-headers-${kernelrelease}",
    ],
    'Fedora' => [
      'bzip2-devel',
      'expat-devel',
      'gdbm-devel',
      'gmp-devel',
      'kernel-devel',
      'kernel-headers',
      'libdb4-devel',
      'libffi-devel',
      'libxml2-devel',
      'libxslt-devel',
      'libyaml-devel',
      'mysql-devel',
      'openldap-devel',
      'openssl-devel',
      'postgresql-devel',
      'qtwebkit-devel',
      'readline-devel',
      'sqlite-devel',
      'tcl-devel',
      'tix-devel',
      'tk-devel',
      'valgrind-devel',
      'zlib-devel',
    ],
  }: ensure => installed }

}
