class tic::services::features::notification_manager {

  tic::ini_settings { 'notification_manager':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.notification.manager.cfg",
    settings => {
      'notification.manager.input.queue'       => $tic::notification_manager_input_queue,
      'notification.manager.destination.queue' => $tic::notification_manager_destination_queue,
    }
  }

}
