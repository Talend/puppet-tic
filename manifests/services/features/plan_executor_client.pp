class tic::services::features::plan_executor_client {

  tic::ini_settings { 'plan_execution_client':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.pe.client.cfg",
    settings => {
      'pe.service.url'      => $tic::pe_service_url,
      'pe.service.username' => $tic::pe_service_username,
      'pe.service.password' => $tic::pe_service_password,
    }
  }

}
