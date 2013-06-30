define users::vimbundle($user, $home = "/home/$user") {

  file { "${home}/.vim/bundle/$name":
    source  => "puppet:///modules/users/$user/vim/bundle/$name",
    recurse => true,
  }

}
