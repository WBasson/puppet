class insync::repository {

  case $::operatingsystem {
    'Debian': {
      apt::source { 'insync':
        location    => 'http://apt.insynchq.com/debian',
        release     => $::lsbdistcodename,
        repos       => 'non-free',
        key         => 'ACCAF35C',
        key_source  => 'https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key',
        include_src => false,
      }
    }
    'Fedora': {
      file { '/etc/yum.repos.d/insync.repo':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/insync/insync.repo',
      }
    }
  }

}
