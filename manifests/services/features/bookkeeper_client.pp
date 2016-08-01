class tic::services::features::bookkeeper_client {

  ini_setting { 'bookkeeper_service_client_url':
      ensure  => present,
      path    => "${tic::services::params::karaf_base_path}/etc/org.talend.ipaas.rt.bookkeeper.client.cfg",
      section => '',
      setting => 'bookkeeper.service.url',
      value   => $tic::services::params::bookkeeper_service_url
  }

}
