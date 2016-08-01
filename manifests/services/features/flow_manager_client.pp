class tic::services::features::flow_manager_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { 'flow_manager_client':
    path     => "${config_dir}/org.talend.ipaas.rt.flowmanager.client.cfg",
    settings => {
      'flow.manager.response.queue' => "ipaas.${tic::services::params::subenv_prefix}.flowmanager.response.queue",
      'flow.manager.service.url'    => $tic::services::params::flow_manager_url,
    }
  }

}
