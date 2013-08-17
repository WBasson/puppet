class openssh {

  include openssh::config
  include openssh::package
  include openssh::service

}
