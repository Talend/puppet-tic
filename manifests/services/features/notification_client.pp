class tic::services::features::notification_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { 'notification_client':
    path     => "${config_dir}/org.talend.ipaas.rt.notification.client.cfg",
    settings => {
      'notification.client.output.queue' => $tic::services::params::notification_manager_input_queue,
      'notification.client.failures.log' => $tic::services::params::notification_client_failures_log,
    }
  }

}
