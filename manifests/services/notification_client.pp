class tic::services::notification_client {
  tic::ini_settings { 'notification_client':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.notification.client.cfg",
    settings => {
      'notification.client.output.queue' => $tic::notification_manager_input_queue,
      'notification.client.failures.log' => $tic::notification_client_failures_log,
    }
  }
}
