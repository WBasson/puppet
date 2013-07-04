class kde::autologin($user) {

  exec { 'enable-kde-autologin':
    command => "sed -i -e 's/^\\#*AutoLoginEnable=.*/AutoLoginEnable=true/' /etc/kde/kdm/kdmrc",
    unless  => "grep '^AutoLoginEnable=true' /etc/kde/kdm/kdmrc",
  }

  exec { 'set-kde-autologin-user':
    command => "sed -i -e 's/^\\#*AutoLoginUser=.*/AutoLoginUser=${user}/' /etc/kde/kdm/kdmrc",
    unless  => "grep '^AutoLoginUser=${user}' /etc/kde/kdm/kdmrc",
    require => User[$user],
  }

}
