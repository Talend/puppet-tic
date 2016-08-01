class tic::services::features::webhooks_service {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { 'webhooks_service':
    path     => "${config_dir}/org.talend.ipaas.rt.webhooks.service.cfg",
    settings => {
      'hook.url.prefix' => $tic::webhooks_external_url,
      'db.host'         => $tic::webhooks_redis_host,
      'db.port'         => $tic::webhooks_redis_port,
    }
  }

}
