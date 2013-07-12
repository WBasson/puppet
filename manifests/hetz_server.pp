Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

$username = 'tom.b'

#package { 'zsh': ensure => installed }

user { $username:
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
]: user => $username }
users::dotfile { [ 'ssh/config', 'ssh/known_hosts' ]: user => $username, mode => '0600' }
users::dotfile { 'zsh': user => $username, recurse => true }

users::script { [
  'env-push.sh',
  'fix_known_hosts.rb',
  'hetz-qualify-hostname.sh',
  's',
  'ssh-add-keys.sh',
]: user => $username }

users::vim { $username: }
users::vimbundle { [
  'colorschemes',
  'fugitive',
  'git',
  'puppet',
  'rails',
  'ruby',
  'syntastic',
]: user => $username }
