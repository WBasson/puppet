Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

$username = $::hostname ? {
  /hamlet(.+)/   => 'tom',
  'tomb-desktop' => 'tomb',
}

include clitools
include devtools
include kerberos
include openssh
include stdlib

if $::operatingsystem == 'Fedora' {
  include chrome
  include skype
}

package { 'clementine': ensure => installed }
package { [ 'clusterssh', 'pssh' ]: ensure => installed }
package { 'elinks': ensure => installed }
package { $::operatingsystem ? {
  'Debian' => 'iceweasel',
  'Fedora' => 'firefox',
}: ensure => installed }
package { [ 'gimp', 'gimp-data-extras' ]: ensure => installed }
package { 'git': ensure => installed }
package { 'inkscape': ensure => installed }
package { 'java-1.7.0-openjdk': ensure => installed }
package { 'mcollective-client': ensure => installed }
package { 'puppet': ensure => installed }
package { 'qmpdclient': ensure => installed }
package { $::operatingsystem ? {
  'Debian' => [ 'remmina', 'remmina-plugin-nx', 'remmina-plugin-vnc' ],
  'Fedora' => [ 'remmina', 'remmina-plugins-nx', 'remmina-plugins-vnc' ],
}: ensure => installed }
package { 'quassel-client': ensure => installed }
package { [ 'ruby', 'rubygems' ]: ensure => installed }
package { [ 'screen', 'tmux' ]: ensure => installed }
package { 'synergy': ensure => installed }
package { $::operatingsystem ? {
  'Debian' => 'icedove',
  'Fedora' => 'thunderbird',
}: ensure => installed }
package { 'vim-enhanced': ensure => installed }
package { $::operatingsystem ? {
  'Debian' => 'wireshark',
  'Fedora' => 'wireshark-gnome',
}: ensure => installed }
package { 'zsh': ensure => installed }

$vboxgroup = $::virtual ? {
  'physical'   => 'vboxusers',
  'virtualbox' => 'vboxsf',
}

user { $username:
  groups  => [ 'dialout', 'wheel', $vboxgroup, ],
  home    => '/home/tom',
  shell   => '/bin/zsh',
  require => Package['zsh'],
}

class { 'kde::autologin': user => $username }

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

if $::virtual == 'physical' {
  users::dropbox { $username: }
}

users::kdeconfig { 'app_launcher_shortcut': user => $username, file => 'kglobalshortcutsrc', group => 'plasma-desktop', key => 'activate widget 2', value => 'Alt+F1,Alt+F1,Activate Application Launcher Widget' }
users::kdeconfig { 'disable_compositing': user => $username, file => 'kwinrc', group => 'Compositing', key => 'Enabled', value => false }
users::kdeconfig { 'font_aliasing': user => $username, group => 'General', key => 'XftAntialias', value => 'true' }
users::kdeconfig { 'font_aliasing_hinting': user => $username, group => 'General', key => 'XftHintStyle', value => 'slight' }
users::kdeconfig { 'font_aliasing_subpixel': user => $username, group => 'General', key => 'XftSubPixel', value => 'rgb' }
users::kdeconfig { 'oxygen_theme': user => $username, file => 'plasmarc', group => 'Theme', key => 'name', value => 'oxygen' }

#users::rvm { $username: }

users::script { [
  'askpass.sh',
  'env-push.sh',
  'fix_known_hosts.rb',
  'hetz-qualify-hostname.sh',
  's',
  'ssh-add-keys.sh',
  'steam_bootstrap.sh',
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
