class tic::services::crypto_service_client {

  $config_dir = $tic::services::config::config_dir

  ini_setting { 'crypto_service_client_url':
    ensure  => present,
    path    => "${config_dir}/org.talend.ipaas.rt.crypto.client.cfg",
    section => '',
    setting => 'crypto.service.url',
    value   => $tic::crypto_service_url
  }

}

