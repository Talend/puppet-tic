class tic::services::features::notification_manager {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.notification.manager.cfg":
    settings => {
      'notification.manager.input.queue'       => $tic::services::params::notification_manager_input_queue,
      'notification.manager.destination.queue' => $tic::services::params::notification_manager_destination_queue,
    }
  }

}
