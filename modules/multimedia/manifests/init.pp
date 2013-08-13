class multimedia {

  include yum::rpmfusion

  if $::operatingsystem == 'Fedora' {

    package { 'gstreamer-plugins-ugly':
      ensure  => installed,
      require => Class['yum::rpmfusion'],
    }

  }

}
