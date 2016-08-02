class tic::services::features::plan_executor_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.pe.client.cfg":
    settings => {
      'pe.service.url'      => $tic::pe_service_url,
      'pe.service.username' => $tic::pe_service_username,
      'pe.service.password' => $tic::pe_service_password,
    }
  }

}
