class clitools {

  package { [
    'colordiff',
    'expect',
    'htop',
    'iftop',
    'iotop',
    'nmap',
    'perl-LWP-Protocol-https',
    'pssh',
    'pwgen',
    'strace',
    'tcpdump',
    'whois',
  ]: ensure => installed }

  if $::operatingsystem == 'Fedora' {
    package { 'yum-utils': ensure => installed }
  }

}
