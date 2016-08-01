class tic::services::features::container_management_service_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  ini_setting { 'container_management_service_url':
    ensure  => present,
    path    => "${config_dir}/org.talend.ipaas.rt.cms.client.cfg",
    section => '',
    setting => 'container.management.service.url',
    value   => $tic::services::params::cms_url;
  }

}
