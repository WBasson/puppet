define users::dropbox($home = "/home/$name") {

  include wget

  exec { "install-dropboxd-for-$name":
    command  => "cd $home && wget -O - 'https://www.dropbox.com/download?plat=lnx.x86_64' | tar xzf - && chown -R $name:$name .dropbox-dist",
    creates  => "$home/.dropbox-dist",
    provider => shell,
  }

  exec { "autostart-dropboxd-for-$name":
    command  => "cd $home/.kde/Autostart && ln -s ../../.dropbox-dist/dropboxd && chown -h $name:$name dropboxd",
    creates  => "$home/.kde/Autostart/dropboxd",
    onlyif   => "[ -d $home/.kde/Autostart ]",
    require  => Exec["install-dropboxd-for-$name"],
    provider => shell,
  }

}
