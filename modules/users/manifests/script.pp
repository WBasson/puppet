define users::script($user, $home = "/home/$user") {

  $path = "${home}/bin"

  if ! defined( File[$path] ) { 
    file { $path:
      ensure => directory,
      owner  => $user,
      group  => $user,
      mode   => '0755',
    }   
  }

  file { "${path}/${name}":
    owner   => $user,
    group   => $user,
    mode    => '0755',
    source  => "puppet:///modules/users/${user}/bin/${name}",
  }

}
