define tic::karaf_service_install (

  $service_ensure  = running,
  $service_enable  = true,
  $java_home       = undef,
  $karaf_base      = undef,
  $owner           = 'root',
  $display         = $name,
  $description     = "Karaf Service : ${name}",
  $start_type      = 'DEMAND_START',
  $conf_properties = {},

) {

  validate_string($karaf_base)
  validate_hash($conf_properties)

  exec { "wrapper install : ${name}":
    environment => ["JAVA_HOME=${java_home}"],
    command     => "${karaf_base}/bin/shell 'wrapper:install -s ${start_type} -n ${name} -d ${display} -D \"${description}\"'",
    user        => $owner,
    creates     => "${karaf_base}/bin/${name}.service"
  }

  if 'DEMAND_START' == $start_type {
    file_line { 'remove WantedBy=default.target line':
      ensure            => absent,
      path              => "${karaf_base}/bin/${name}.service",
      line              => 'WantedBy=default.target',
      match             => 'WantedBy=default.target',
      match_for_absence => true,
      before            => Exec["enable service : ${name}"],
      require           => Exec["wrapper install : ${name}"],
    }
  }

  exec { "enable service : ${name}":
    command => "/usr/bin/systemctl enable ${karaf_base}/bin/${name}.service",
    require => Exec["wrapper install : ${name}"],
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
