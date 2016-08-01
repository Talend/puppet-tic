class tic::services::features::plan_executor_service {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { 'plan_execution_service':
    path     => "${config_dir}/org.talend.ipaas.rt.pe.datasource.cfg",
    settings => {
      'datasource.servername' => $tic::services::params::pe_db_host,
      'datasource.password'   => $tic::services::params::pe_db_password,
    }
  }

}
