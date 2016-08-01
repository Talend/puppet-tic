class tic::services::features::artifact_manager_client_runtime {

  ini_setting {
    'artifact_manager_service_client_url':
      ensure  => present,
      path    => "${tic::services::params::karaf_base_path}/etc/org.talend.ipaas.rt.am.client.cfg",
      section => '',
      setting => 'address',
      value   => $tic::services::params::artifact_manager_url
  }

}
