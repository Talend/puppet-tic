class tic::services::account_manager_client {

  $config_dir = $tic::services::config::config_dir

  ini_setting { 'account_manager_client_url':
    ensure  => present,
    path    => "${config_dir}/org.talend.ipaas.rt.ams.client.cfg",
    section => '',
    setting => 'ams.service.url',
    value   => $tic::ams_url,
  }

}

