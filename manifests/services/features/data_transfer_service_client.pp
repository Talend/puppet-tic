class tic::services::features::data_transfer_service_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  ini_setting { 'dts_service_url':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.dts.client.cfg",
      section => '',
      setting => 'dts.service.url',
      value   => $tic::services::params::dts_service_url;
  }

}
