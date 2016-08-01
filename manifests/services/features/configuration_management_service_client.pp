class tic::services::features::configuration_management_service_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  ini_setting { 'configuration_service_url':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.config.client.cfg",
      section => '',
      setting => 'configuration.service.url',
      value   => $tic::services::params::config_service_url;
  }

}
