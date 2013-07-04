define users::kdeconfig($user, $group, $key, $value, $file = '') {

  $file_opt = $file ? {
    /^$/    => '',
    default => "--file ${file}",
  }

  exec { "kwriteconfig_${user}_${file}_${group}_${key}_${value}":
    command => "su ${user} -c 'kwriteconfig ${file_opt} --group ${group} --key ${key} ${value}'",
    unless  => "su ${user} -c 'kreadconfig ${file_opt} --group ${group} --key ${key}' | grep -q '${value}'",
  }

}
