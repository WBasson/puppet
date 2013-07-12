define users::vim($group = $name, $home = "/home/$name") {

  file { [ "$home/.vim", "$home/.vim/autoload", "$home/.vim/bundle" ]:
    ensure => directory,
    owner => $name,
    group => $group,
    mode => '0755',
    require => User[$name],
  }

  file { "$home/.vim/autoload/pathogen.vim":
    ensure  => file,
    owner   => $name,
    group   => $group,
    mode    => '0644',
    source  => "puppet:///modules/users/$name/vim/autoload/pathogen.vim",
    require => File["$home/.vim/autoload"],
  }

}
