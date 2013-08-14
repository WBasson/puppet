class vagrant {

  $vagrant_version = '1.2.7'

  if $::operatingsystem == 'Fedora' {

    $vagrant_rpm_url = "http://files.vagrantup.com/packages/7ec0ee1d00a916f80b109a298bab08e391945243/vagrant_${vagrant_version}_${::architecture}.rpm"

    exec { 'install-vagrant':
      command => "yum install -y ${vagrant_rpm_url}",
      unless  => "rpm -q vagrant-${vagrant_version}",
    }

  }

}
