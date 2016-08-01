class tic::services::features::data_transfer_service_client {

  $config_dir = $tic::services::config::config_dir

  ini_setting {
    'dts_service_url':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.dts.client.cfg",
      section => '',
      setting => 'dts.service.url',
      value   => $tic::dts_service_url;
  }

}
