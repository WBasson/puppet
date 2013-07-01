class clitools {

  package { [ 'colordiff' ]: ensure => installed }
  package { [ 'htop', 'iftop', 'iotop' ]: ensure => installed }
  package { [ 'pwgen' ]: ensure => installed }
  package { [ 'strace' ]: ensure => installed }
  package { [ 'whois' ]: ensure => installed }

}
