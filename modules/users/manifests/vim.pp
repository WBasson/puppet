define users::vim($home = "/home/$name") {

  file { [ "$home/.vim", "$home/.vim/autoload", "$home/.vim/bundle" ]:
    ensure => directory,
    owner => $name,
    group => $name,
    mode => '0755',
    require => User[$name],
  }

  file { "$home/.vim/autoload/pathogen.vim":
    ensure  => file,
    owner   => $name,
    group   => $name,
    mode    => '0644',
    source  => "puppet:///modules/users/$name/vim/autoload/pathogen.vim",
    require => File["$home/.vim/autoload"],
  }

}
