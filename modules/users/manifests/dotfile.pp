define users::dotfile($user, $home = "/home/$user", $mode = '0644', $recurse = false) {

  if $name =~ /\// {
    $directory = regsubst($name, '^(.+)/([^/]+)', "$home/.\\1")
    if ! defined(File[$directory]) {
      file { $directory:
        ensure  => directory,
        owner   => $user,
        group   => $user,
        mode    => $mode,
        require => User[$user],
      }
    }
  }

  file { "$home/.$name":
    ensure  => present,
    owner   => $user,
    group   => $user,
    mode    => $mode,
    recurse => $recurse,
    source  => "puppet:///modules/users/$user/dotfiles/$name",
    require => User[$user],
  }

}
