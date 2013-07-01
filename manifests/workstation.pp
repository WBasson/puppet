Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

include chrome
include clitools
include kerberos
include openssh
include skype
include stdlib

package { 'clementine': ensure => installed }
package { [ 'clusterssh', 'pssh' ]: ensure => installed }
package { 'elinks': ensure => installed }
package { 'firefox': ensure => installed }
package { [ 'gimp', 'gimp-data-extras' ]: ensure => installed }
package { 'git': ensure => installed }
package { 'java-1.7.0-openjdk': ensure => installed }
package { 'mcollective-client': ensure => installed }
package { 'puppet': ensure => installed }
package { 'qmpdclient': ensure => installed }
package { [ 'remmina', 'remmina-plugins-nx', 'remmina-plugins-vnc' ]: ensure => installed }
package { [ 'ruby', 'rubygems' ]: ensure => installed }
package { [ 'screen', 'tmux' ]: ensure => installed }
package { 'synergy': ensure => installed }
package { 'vim-enhanced': ensure => installed }
package { 'wireshark-gnome': ensure => installed }
package { 'zsh': ensure => installed }

user { 'tom':
  home    => '/home/tom',
  shell   => '/bin/zsh',
  require => Package['zsh'],
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
]: user => 'tom' }
users::dotfile { [ 'ssh/config', 'ssh/known_hosts' ]: user => 'tom', mode => '0600' }
users::dotfile { 'zsh': user => 'tom', recurse => true }

users::dropbox { 'tom': }

#users::rvm { 'tom': }

users::script { [
  'askpass.sh',
  'env-push.sh',
  'fix_known_hosts.rb',
  'hetz-qualify-hostname.sh',
  's',
  'ssh-add-keys.sh',
  'steam_bootstrap.sh',
]: user => 'tom' }

users::vim { 'tom': }
users::vimbundle { [
  'colorschemes',
  'fugitive',
  'git',
  'puppet',
  'rails',
  'ruby',
  'syntastic',
]: user => 'tom' }
