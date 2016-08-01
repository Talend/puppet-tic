class tic::services::features::account_manager_client {

  ini_setting { 'account_manager_client_url':
    ensure  => present,
    path    => "${tic::services::params::karaf_base_path}/etc/org.talend.ipaas.rt.ams.client.cfg",
    section => '',
    setting => 'ams.service.url',
    value   => $tic::services::params::ams_url,
  }

}
