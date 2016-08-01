class tic::services::features::webhooks_service {

  tic::ini_settings { 'webhooks_service':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.webhooks.service.cfg",
    settings => {
      'hook.url.prefix' => $tic::webhooks_external_url,
      'db.host'         => $tic::webhooks_redis_host,
      'db.port'         => $tic::webhooks_redis_port,
    }
  }

}
