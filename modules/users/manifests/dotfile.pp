define users::dotfile($user, $group = $user, $home = "/home/$user", $mode = false, $recurse = false, $template = false) {

  if $name =~ /\// {
    $directory = regsubst($name, '^(.+)/([^/]+)', "$home/.\\1")
    if ! defined(File[$directory]) {
      file { $directory:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => $mode ? {
          false   => '0644',
          default => $mode,
        },
        require => User[$user],
      }
    }
  }

  file { "${home}/.${name}":
    ensure  => present,
    owner   => $user,
    group   => $group,
    recurse => $recurse,
    ignore  => '.git',
    require => User[$user],
  }

  if $mode != false {
    File["${home}/.${name}"] {
      mode => $mode,
    }
  }

  if $template == false {
    File["${home}/.${name}"] {
      source => "puppet:///modules/users/${user}/dotfiles/${name}",
    }
  } else {
    File["$home/.$name"] {
      content => template("users/${user}/dotfiles/${name}.erb"),
    }
  }

}
