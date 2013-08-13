class clitools {

  package { [
    'colordiff',
    'expect',
    'htop',
    'iftop',
    'iotop',
    'nmap',
    'pssh',
    'pwgen',
    'strace',
    'tcpdump',
    'whois',
  ]: ensure => installed }

  package { $::operatingsystem ? {
    'Debian' => 'libwww-perl',
    'Fedora' => [ 'perl-LWP-Protocol-https', 'yum-utils' ],
  }: ensure => installed }

}
