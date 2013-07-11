class virtualbox::repository {

  case $::operatingsystem {
    'Debian': {
      $repos = $::lsbdistcodename ? {
        /(squeeze|lenny)/ => 'contrib non-free',
        default           => 'contrib',
      }
      apt::source { 'virtualbox':
        location    => 'http://download.virtualbox.org/virtualbox/debian',
        release     => $::lsbdistcodename,
        repos       => $repos,
        key         => '98AB5139',
        key_source  => 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc',
        include_src => false,
      }
    }
    'Fedora': {
      file { '/etc/yum.repos.d/virtualbox.repo':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/virtualbox/virtualbox.repo',
      }
    }
  }

}
