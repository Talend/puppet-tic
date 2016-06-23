class tic::services::notification_subscription_service {
  tic::ini_settings { 'notification_subscription_service':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.notification.subscription.service.cfg",
    settings => {
      'db.host'            => $tic::notification_subscription_db_host,
      'db.port'            => $tic::notification_subscription_db_port,
      'db.password'        => $tic::notification_subscription_db_password,
      'db.max.connections' => $tic::notification_subscription_db_max_connections,
    }
  }
}
