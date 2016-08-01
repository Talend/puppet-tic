class tic::services::features::flow_manager_client {

  tic::ini_settings { 'flow_manager_client':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.flowmanager.client.cfg",
    settings => {
      'flow.manager.response.queue' => "ipaas.${tic::subenv_prefix}.flowmanager.response.queue",
      'flow.manager.service.url'    => $tic::flow_manager_url                                  ,
    }
  }

}
