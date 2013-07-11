class rubygems {

  include devtools

  package { [ 'ruby', 'rubygems' ]: ensure => installed }
  package { 'rake': ensure => installed, provider => 'gem' }

}
