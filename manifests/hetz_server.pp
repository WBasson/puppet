Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

$username = 'tom.b'
$group = 'staff'

#package { 'zsh': ensure => installed }

user { $username:
  gid      => $group,
  #shell   => '/bin/zsh',
  #require => Package['zsh'],
}

users::dotfile { [
  'aliases',
  'bashrc',
  'env',
  'gitconfig',
  'gitignore_global',
  'profile',
  'screenrc',
  'shell_colours',
  'vimrc',
  'zshrc',
]: user => $username, group => $group }
users::dotfile { [ 'ssh/config', 'ssh/known_hosts' ]: user => $username, group => $group, mode => '0600' }
users::dotfile { 'zsh': user => $username, group => $group, recurse => true }

users::script { [
  'env-push.sh',
  'fix_known_hosts.rb',
  'hetz-qualify-hostname.sh',
  's',
  'ssh-add-keys.sh',
]: user => $username, group => $group }

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
