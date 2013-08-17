class skype {

  include skype::dependencies

  $version = '4.2.0.11'

  case $::operatingsystem {
    'Debian': {

      $md5sum = '229fc46e22a5fe5122823d401e8e9098'

      exec { 'install-skype':
        command  => "if ! [ -f /tmp/skype.deb ] || md5sum /tmp/skype.deb | awk '{print \$1;}' | grep -qv '^${md5sum}$'; then \
                    wget 'http://download.skype.com/linux/skype-debian_${version}-1_i386.deb' -O /tmp/skype.deb; fi; \
                    dpkg -i /tmp/skype.deb; apt-get -y -f install; dpkg -l | grep skype | grep -q '^ii'",
        provider => 'shell',
        unless   => 'dpkg -l | grep skype | grep -q "^ii"',
      }

    }
    'Fedora': {

      exec { 'install-skype':
        command => "yum install --nogpgcheck -y http://download.skype.com/linux/skype-${version}-fedora.i586.rpm",
        unless  => "rpm -q skype-${version}",
        require => Class['skype::dependencies'],
      }

    }
  }

}
