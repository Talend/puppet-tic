define tic::karaf_service_install (

  $service_ensure  = running,
  $service_enable  = true,
  $java_home       = undef,
  $karaf_base      = undef,
  $owner           = 'root',
  $display         = $name,
  $description     = "Karaf Service : ${name}",
  $conf_properties = {},

) {
  validate_string($karaf_base)
  validate_hash($conf_properties)

  exec { "wrapper install : ${name}":
    environment => ["JAVA_HOME=${java_home}"],
    command     => "${karaf_base}/bin/shell 'wrapper:install -n ${name} -d ${display} -D \"${description}\"'",
    user        => $owner,
    creates     => "${karaf_base}/bin/${name}.service"
  } ->
  exec { "enable service : ${name}":
    command => "/usr/bin/systemctl enable ${karaf_base}/bin/${name}.service",
    creates => "/etc/systemd/system/${name}"
  } ->
  tic::ini_settings { "update properties : ${name}":
    path     => "${karaf_base}/etc/${name}-wrapper.conf",
    settings => $conf_properties
  } ~>
  service { $name:
    ensure   => $service_ensure,
    provider => 'systemd',
    enable   => $service_enable,
  }
}
