class tic::services::artifact_manager_client {

  $config_dir = $tic::services::config::config_dir

  ini_setting {
    'artifact_manager_service_client_url':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.am.client.cfg",
      section => '',
      setting => 'address',
      value   => $tic::artifact_manager_url
  }

}

