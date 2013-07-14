class clitools {

  $packages = [
    'colordiff',
    'expect',
    'htop',
    'iftop',
    'iotop',
    'nmap',
    'perl-LWP-Protocol-https',
    'pwgen',
    'strace',
    'tcpdump',
    'whois',
  ]

  package { $packages: ensure => installed }

}
