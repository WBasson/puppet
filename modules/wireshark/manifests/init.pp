class wireshark {

  package { $::operatingsystem ? {
    'Debian' => 'wireshark',
    'Fedora' => 'wireshark-gnome',
  }: ensure => installed }

}
