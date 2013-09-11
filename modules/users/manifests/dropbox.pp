define users::dropbox($home = "/home/${name}") {

  include wget

  exec { "install-dropboxd-for-${name}":
    command  => "wget -O - 'https://www.dropbox.com/download?plat=lnx.x86_64' | tar xzf - && chown -R ${name}:${name} .dropbox-dist",
    creates  => "${home}/.dropbox-dist",
    cwd      => $home,
    provider => shell,
  }

  #  file { "autostart-dropboxd-for-${name}":
  # ensure   => link,
  # path     => "${home}/.kde/Autostart/dropboxd",
  # target   => "../../.dropbox-dist/dropboxd",
  # require  => Exec["install-dropboxd-for-${name}"],
 #}

}
