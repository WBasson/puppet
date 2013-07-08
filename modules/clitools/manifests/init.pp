class clitools {

  $packages = [
    'colordiff',
    'htop',
    'iftop',
    'iotop',
    'nmap',
    'pwgen',
    'strace',
    'tcpdump',
    'whois',
  ]

  package { $packages: ensure => installed }

}
