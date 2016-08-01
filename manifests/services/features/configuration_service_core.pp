class tic::services::features::configuration_service_core {
  tic::ini_settings { 'configuration_management_service':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.config.core.cfg",
    settings => {
      'db.host'     => $tic::config_db_host,
      'db.password' => $tic::config_db_password,
    }
  }
}
