class tic::services::features::webhooks_service {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.webhooks.service.cfg":
    settings => {
      'hook.url.prefix' => $tic::services::params::webhooks_external_url,
      'db.host'         => $tic::services::params::webhooks_redis_host,
      'db.port'         => $tic::services::params::webhooks_redis_port,
    }
  }

}
