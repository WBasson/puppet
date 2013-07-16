define users::vimbundle($user, $group = $user, $home = "/home/$user") {

  file { "${home}/.vim/bundle/$name":
    owner   => $user,
    group   => $group,
    mode    => '0644',
    recurse => true,
    ignore  => '.git',
    source  => "puppet:///modules/users/$user/vim/bundle/$name",
  }

}
