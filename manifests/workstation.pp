Exec {
  path => '/bin:/sbin:/usr/bin:/usr/sbin',
}

include stdlib

package { 'clementine': ensure => installed }
package { 'colordiff': ensure => installed }
package { 'elinks': ensure => installed }
package { 'firefox': ensure => installed }
package { 'gimp': ensure => installed }
package { 'gimp-data-extras': ensure => installed }
package { 'git': ensure => installed }
package { 'mcollective-client': ensure => installed }
package { 'puppet': ensure => installed }
package { 'ruby': ensure => installed }
package { 'rubygems': ensure => installed }
package { 'vim-enhanced': ensure => installed }
package { 'zsh': ensure => installed }

user { 'tom':
  home    => '/home/tom',
  shell   => '/bin/zsh',
  require => Package['zsh'],
}

$dotfiles = [
  'aliases',
  'bashrc',
  'env',
  'gitconfig',
  'gitignore_global',
  'profile',
  'screenrc',
  'shell_colours',
  'ssh/config',
  'ssh/known_hosts',
  'vimrc',
  'zshrc',
]
users::dotfile { $dotfiles: user => 'tom' }
users::vim { 'tom': }
users::vimbundle { 'puppet': user => 'tom' }
users::vimbundle { 'fugitive': user => 'tom' }
users::vimbundle { 'syntastic': user => 'tom' }
users::vimbundle { 'rails': user => 'tom' }
users::vimbundle { 'git': user => 'tom' }
users::vimbundle { 'ruby': user => 'tom' }
users::vimbundle { 'colorschemes': user => 'tom' }
