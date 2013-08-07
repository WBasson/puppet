define users::dotfile($user, $group = $user, $home = "/home/$user", $mode = false, $recurse = false) {

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

  $ignore = '.git'
  $source = "puppet:///modules/users/$user/dotfiles/$name"

  # Ouch, either we set a mode or we inherit from the source file
  if $mode == false {
    file { "$home/.$name":
      ensure  => present,
      owner   => $user,
      group   => $group,
      recurse => $recurse,
      ignore  => $ignore,
      source  => $source,
      require => User[$user],
    }
  } else {
    file { "$home/.$name":
      ensure  => present,
      owner   => $user,
      group   => $group,
      mode    => $mode,
      recurse => $recurse,
      ignore  => $ignore,
      source  => $source,
      require => User[$user],
    }
  }

}
