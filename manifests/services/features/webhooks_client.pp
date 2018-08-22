class tic::services::features::webhooks_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.webhooks.client.cfg":
    settings => {
      'webhooks.service.url' => $tic::services::params::webhooks_url,
    }
  }

}
