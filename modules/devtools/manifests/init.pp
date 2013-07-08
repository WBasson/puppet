class devtools {

  $packages = $::operatingsystem ? {
    'Debian' => [
      'build-essential',
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

  if $::operatingsystem == 'Debian' {
    exec { 'install-linux-headers':
      command  => 'apt-get install linux-headers-$(uname -r)',
      provider => 'shell',
      unless   => 'dpkg -l | grep linux-headers-$(uname -r) | grep -q "^ii"',
    }
  }

}
