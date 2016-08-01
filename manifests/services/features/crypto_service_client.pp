class tic::services::features::crypto_service_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  ini_setting { 'crypto_service_client_url':
    ensure  => present,
    path    => "${config_dir}/org.talend.ipaas.rt.crypto.client.cfg",
    section => '',
    setting => 'crypto.service.url',
    value   => $tic::services::params::crypto_service_url
  }

}
