class tic::services::features::bookkeeper_client {

  $config_dir = $tic::services::config::config_dir

  ini_setting {
    'bookkeeper_service_client_url':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.bookkeeper.client.cfg",
      section => '',
      setting => 'bookkeeper.service.url',
      value   => $tic::bookkeeper_service_url
  }

}

