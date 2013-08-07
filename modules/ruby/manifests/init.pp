class ruby {

  include dev::libs
  include dev::tools

  package { [ 'ruby', 'rubygems' ]: ensure => installed }
  package { 'rake': ensure => installed, provider => 'gem' }

}
