Exec {
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  timeout => 0,
}

$username = 'tom'

include chrome
include clitools
include devtools
include insync
include kerberos
include multimedia
include openssh
#include ruby
include skype
include stdlib

if $::virtual == 'physical' {
  include virtualbox
}

if $::operatingsystem == 'Fedora' {
  include yum::rpmfusion
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
package { $::operatingsystem ? {
  'Debian' => [ 'openjdk-6-jre', 'openjdk-7-jre' ],
  'Fedora' => 'java-1.7.0-openjdk',
}: ensure => installed }
package { 'kate': ensure => installed }
package { 'mcollective-client': ensure => installed }
package { 'puppet': ensure => installed }
package { 'qmpdclient': ensure => installed }
package { 'quassel-client': ensure => installed }
package { $::operatingsystem ? {
  'Debian' => [ 'remmina', 'remmina-plugin-nx', 'remmina-plugin-vnc' ],
  'Fedora' => [ 'remmina', 'remmina-plugins-nx', 'remmina-plugins-vnc' ],
}: ensure => installed }
package { $::operatingsystem ? {
  'Debian' => 'quassel-client-kde4',
  'Fedora' => 'quassel-client',
}: ensure => installed }
package { [ 'ruby', 'rubygems' ]: ensure => installed }
package { [ 'screen', 'tmux' ]: ensure => installed }
package { 'synergy': ensure => installed }
package { $::operatingsystem ? {
  'Debian' => 'icedove',
  'Fedora' => 'thunderbird',
}: ensure => installed }
package { $::operatingsystem ? {
  'Debian' => 'vim',
  'Fedora' => 'vim-enhanced',
}: ensure => installed }
package { $::operatingsystem ? {
  'Debian' => 'wireshark',
  'Fedora' => 'wireshark-gnome',
}: ensure => installed }
package { 'zsh': ensure => installed }

$common_groups =  [ 'dialout', 'sudo', 'wireshark', $::virtual ? {
  'physical'   => 'vboxusers',
  'virtualbox' => 'vboxsf',
} ]

$groups = $::operatingsystem ? {
  'Debian' => concat($common_groups, [ 'adm', 'cdrom', 'fuse', 'plugdev', 'lpadmin' ]),
  'Fedora' => concat($common_groups, [ 'wheel' ]),
}

user { $username:
  groups  => $groups,
  home    => "/home/${username}",
  shell   => '/bin/zsh',
  require => [ Class['virtualbox::package'], Package['zsh'] ],
}

if $::operatingsystem == 'Fedora' {
  #class { 'kde::autologin': user => $username }
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

if $::virtual == 'physical' {
  users::dropbox { $username: }
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
