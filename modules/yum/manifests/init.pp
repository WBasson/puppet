class yum {

  include yum::config
  include yum::packages
  include yum::rpmfusion

}
