class tic::services::container_management_service_client {

  $config_dir = $tic::services::config::config_dir

  ini_setting {
    'container_management_service_url':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.cms.client.cfg",
      section => '',
      setting => 'container.management.service.url',
      value   => $tic::cms_url;

  }

}
