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
    command     => "${karaf_base}/bin/shell 'wrapper:install'",
    user        => $owner,
    creates     => "${karaf_base}/bin/karaf.service"
  }

  if 'DEMAND_START' == $start_type {
    file_line { 'remove WantedBy=default.target line':
      ensure            => absent,
      path              => "${karaf_base}/bin/karaf.service",
      line              => 'WantedBy=default.target',
      match             => 'WantedBy=default.target',
      match_for_absence => true,
      before            => Exec["enable service : ${name}"],
      require           => Exec["wrapper install : ${name}"],
    }
    file_line { 'Add LimitNOFILE to systemd service':
      ensure   => present,
      path     => "${karaf_base}/bin/karaf.service",
      after    => 'ExecStop=/opt/talend/ipaas/rt-infra/bin/karaf-service stop',
      multiple => false,
      line     => 'LimitNOFILE=8192',
      before   => Exec["enable service : ${name}"],
      require  => Exec["wrapper install : ${name}"],
    }
    file_line { 'Add LimitNPROC to systemd service':
      ensure   => present,
      path     => "${karaf_base}/bin/karaf.service",
      after    => 'ExecStop=/opt/talend/ipaas/rt-infra/bin/karaf-service stop',
      multiple => false,
      line     => 'LimitNPROC=8192',
      before   => Exec["enable service : ${name}"],
      require  => Exec["wrapper install : ${name}"],
    }
  }

  exec { "enable service : ${name}":
    command => "/usr/bin/systemctl enable ${karaf_base}/bin/karaf.service",
    require => Exec["wrapper install : ${name}"],
  } ->
  tic::ini_settings { "update properties : ${name}":
    path     => "${karaf_base}/etc/karaf-wrapper.conf",
    settings => $conf_properties
  } ~>
  service { 'karaf':
    ensure   => $service_ensure,
    provider => 'systemd',
    enable   => $service_enable,
  }

}
