
class tic::services::features::plan_executor_service {
  tic::ini_settings { 'plan_execution_service':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.pe.datasource.cfg",
    settings => {
      'datasource.servername' => $tic::pe_db_host,
      'datasource.password'   => $tic::pe_db_password,
    }
  }

}
