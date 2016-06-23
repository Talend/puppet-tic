class tic::services::dispatcher_client {
  tic::ini_settings { 'dispatcher_client':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.dispatcher.client.cfg",
    settings => {
      'dispatcher.input.queue'    => "ipaas.${tic::subenv_prefix}.dispatcher.input.queue",
      'dispatcher.response.queue' => "ipaas.${tic::subenv_prefix}.dispatcher.response.queue",
    }
  }
}
