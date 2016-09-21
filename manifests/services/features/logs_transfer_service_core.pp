class tic::services::features::logs_transfer_service_core {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.lts.core.cfg":
    settings => {
      'presignedurl.timetolive' => $tic::services::params::logs_transfer_presignedurl_timetolive,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.lts.datasource.cfg":
    settings => {
      'datasource.servername'   => $tic::services::params::logs_datasource_servername,
      'datasource.databasename' => 'lts',
      'datasource.username'     => 'lts',
      'datasource.password'     => $tic::services::params::logs_datasource_password,
    }
  }

}
