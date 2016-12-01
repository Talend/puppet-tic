class tic::services::features::notification_subscription_service {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.notification.subscription.service.cfg":
    settings => {
      'db.host'            => $tic::services::params::notification_subscription_db_host,
      'db.port'            => $tic::services::params::notification_subscription_db_port,
      'db.name'            => $tic::services::params::notification_subscription_db_name,
      'db.username'        => $tic::services::params::notification_subscription_db_username,
      'db.password'        => $tic::services::params::notification_subscription_db_password,
      'db.max_connections' => $tic::services::params::notification_subscription_db_max_connections,
    }
  }

}
