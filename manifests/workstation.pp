include stdlib

if $::hostname =~ /^(hamlet(-vm)?|tomb-(dell|desktop|laptop|workstation)|(debian|fedora|ubuntu)-vm)$/ {
  $role = 'workstation'
} elsif $::domain =~ /.+\.host-h\.net/ {
  $role = 'hetz_server'
} else {
  $role = 'default'
}

if $::domain =~ /(.+\.host-h\.net)|(hetzner\.africa)/ {
  $location = 'hetzner'
} else {
  $location = 'roaming'
}

notify { 'role_location': message => "Applying role \"${role}\" at location \"${location}\"" }

Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

$username = $role ? {
  'hetz_server' => 'tom.b',
  'workstation' => 'tom',
  default       => 'tom',
}

$group = $role ? {
  'hetz_server' => 'staff',
  'workstation' => 'tom',
  default       => 'tom',
}

case $role {
  'workstation': {

    include chrome
    include clitools
    include dev::libs
    include dev::tools
    include insync
    include kde
    include kerberos
    include ldap
    include multimedia
    include openssh
    include ruby
    include selinux
    include skype
    include ssl
    include vagrant
    include wireshark
    include yum::rpmfusion

    if $::virtual == 'physical' {
      include virtualbox
    }

    package { $::operatingsystem ? {
      'Debian' => [ 'avahi-daemon', 'avahi-utils' ],
      'Fedora' => 'avahi',
    }: ensure => installed }
    package { 'clementine': ensure => installed }
    package { 'clusterssh': ensure => installed }
    package { 'cups': ensure => installed }
    package { 'elinks': ensure => installed }
    package { $::operatingsystem ? {
      'Debian' => 'iceweasel',
      'Fedora' => 'firefox',
    }: ensure => installed }
    package { [ 'gimp', 'gimp-data-extras' ]: ensure => installed }
    package { 'git': ensure => installed }
    package { 'inkscape': ensure => installed }
    package { $::operatingsystem ? {
      'Debian' => [ 'openjdk-6-jre', 'openjdk-7-jre' ],
      'Fedora' => 'java-1.7.0-openjdk',
    }: ensure => installed }
    package { 'kate': ensure => installed }
    package { 'mcollective-client': ensure => installed }
    package { $::operatingsystem ? {
      'Debian' => [ 'php5-cgi', 'php5-cli' ],
      'Fedora' => [ 'php' ],
    }: ensure => installed }
    package { 'puppet': ensure => installed }
    package { 'qmpdclient': ensure => installed }
    package { $::operatingsystem ? {
      'Debian' => 'quassel-client-kde4',
      'Fedora' => 'quassel-client',
    }: ensure => installed }
    package { $::operatingsystem ? {
      'Debian' => [ 'remmina', 'remmina-plugin-nx', 'remmina-plugin-vnc' ],
      'Fedora' => [ 'remmina', 'remmina-plugins-nx', 'remmina-plugins-vnc' ],
    }: ensure => installed }
    package { [ 'screen', 'tmux' ]: ensure => installed }
    package { 'synergy': ensure => installed }
    package { $::operatingsystem ? {
      'Debian' => 'icedove',
      'Fedora' => 'thunderbird',
    }: ensure => installed }
    package { 'transmission-qt': ensure => installed }
    package { 'unetbootin': ensure => installed }
    package { $::operatingsystem ? {
      'Debian' => 'vim',
      'Fedora' => 'vim-enhanced',
    }: ensure => installed }
    package { 'zsh': ensure => installed }

    $common_groups =  [ 'dialout', $::virtual ? {
      'physical' => 'vboxusers',
      default    => 'vboxsf',
    } ]

    $groups = $::operatingsystem ? {
      'Debian' => concat($common_groups, [ 'adm', 'cdrom', 'fuse', 'plugdev', 'lpadmin', 'sudo' ]),
      'Fedora' => concat($common_groups, [ 'lp', 'wheel', 'wireshark' ]),
    }

    $user_require = $::virtual ? {
      'physical' => [ Class['virtualbox::package'], Class['wireshark'], Package['cups'], Package['zsh'] ],
      default    => [ Class['wireshark'], Package['cups'], Package['zsh'] ],
    }

    user { $username:
      gid     => $group,
      groups  => $groups,
      home    => "/home/${username}",
      shell   => '/bin/zsh',
      require => $user_require,
    }

    if $::operatingsystem == 'Fedora' {
      #class { 'kde::autologin': user => $username }
    }

    #users::kdeconfig { 'app_launcher_shortcut': user => $username, file => 'kglobalshortcutsrc', group => 'plasma-desktop', key => 'activate widget 2', value => 'Alt+F1,Alt+F1,Activate Application Launcher Widget' }
    #users::kdeconfig { 'disable_compositing': user => $username, file => 'kwinrc', group => 'Compositing', key => 'Enabled', value => false }
    #users::kdeconfig { 'font_aliasing': user => $username, group => 'General', key => 'XftAntialias', value => 'true' }
    #users::kdeconfig { 'font_aliasing_hinting': user => $username, group => 'General', key => 'XftHintStyle', value => 'slight' }
    #users::kdeconfig { 'font_aliasing_subpixel': user => $username, group => 'General', key => 'XftSubPixel', value => 'rgb' }
    #users::kdeconfig { 'oxygen_theme': user => $username, file => 'plasmarc', group => 'Theme', key => 'name', value => 'oxygen' }

    #users::rvm { $username: }

    users::script { [
      'askpass.sh',
      'env-push.sh',
      'fix_known_hosts.rb',
      'hetz-qualify-hostname.sh',
      's',
      'ssh-add-keys.sh',
      'steam_bootstrap.sh',
    ]: user => $username, group => $group }

    if $::virtual == 'physical' {
      users::dropbox { $username: }
    }

  }
  'hetz_server': {

    user { $username:
      gid      => $group,
      #shell   => '/bin/zsh',
      #require => Package['zsh'],
    }

    users::script { [
      'env-push.sh',
      'fix_known_hosts.rb',
      'hetz-qualify-hostname.sh',
      's',
      'ssh-add-keys.sh',
    ]: user => $username, group => $group }

  }

}

users::dotfile { [
  'aliases',
  'bashrc',
  'env',
  'gitconfig',
  'gitignore_global',
  'hushlogin',
  'ldaprc',
  'profile',
  'screenrc',
  'shell_colours',
  'vimrc',
  'zshrc',
]: user => $username, group => $group }

users::dotfile { 'ssh/authorized_keys': user => $username, group => $group, mode => '0600', template => true }
users::dotfile { [ 'ssh/config', 'ssh/known_hosts' ]: user => $username, group => $group, mode => '0600' }
users::dotfile { [ 'pyenv', 'zsh' ]: user => $username, group => $group, recurse => true }

users::vim { $username: group => $group }
users::vimbundle { [
  'colorschemes',
  'fugitive',
  'git',
  'puppet',
  'rails',
  'ruby',
  'syntastic',
]: user => $username, group => $group }
