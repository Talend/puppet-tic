class tic::services::features::configuration_management_service_client {

  $config_dir = $tic::services::config::config_dir
  $conf_file = "${config_dir}/org.talend.ipaas.rt.config.client.cfg"

  ini_setting {
    'configuration_service_url':
      ensure  => present,
      path    => $conf_file,
      section => '',
      setting => 'configuration.service.url',
      value   => $tic::config_service_url;
  }
}
