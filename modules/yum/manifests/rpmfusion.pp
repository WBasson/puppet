class yum::rpmfusion {

  if $::operatingsystem == 'Fedora' {

    exec { 'enable-rpmfusion-free-yum-repo':
      command => 'yum -y --nogpgcheck install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm',
      unless  => 'rpm -q rpmfusion-free-release',
    }

    exec { 'enable-rpmfusion-nonfree-yum-repo':
      command => 'yum -y --nogpgcheck install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm',
      unless  => 'rpm -q rpmfusion-nonfree-release',
    }

  }

}
