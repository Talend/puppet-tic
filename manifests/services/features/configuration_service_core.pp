class tic::services::features::configuration_service_core {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { 'configuration_management_service':
    path     => "${config_dir}/org.talend.ipaas.rt.config.core.cfg",
    settings => {
      'db.host'     => $tic::services::params::config_db_host,
      'db.password' => $tic::services::params::config_db_password,
    }
  }

}
