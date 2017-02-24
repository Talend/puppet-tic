class tic::services::features::dispatcher_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.dispatcher.client.cfg":
    settings => {
      'dispatcher.input.queue'    => $tic::services::params::dispatcher_input_queue,
      'dispatcher.response.queue' => $tic::services::params::dispatcher_response_queue,
    }
  }

}
