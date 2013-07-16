define users::dotfile($user, $group = $user, $home = "/home/$user", $mode = '0644', $recurse = false) {

  if $name =~ /\// {
    $directory = regsubst($name, '^(.+)/([^/]+)', "$home/.\\1")
    if ! defined(File[$directory]) {
      file { $directory:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => $mode,
        require => User[$user],
      }
    }
  }

  file { "$home/.$name":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => $mode,
    recurse => $recurse,
    ignore  => '.git',
    source  => "puppet:///modules/users/$user/dotfiles/$name",
    require => User[$user],
  }

}
