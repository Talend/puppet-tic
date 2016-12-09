class tic::frontend::service {

  require ::tic::frontend::config

  file { '/usr/lib/systemd/system/tomcat-ipaas-srv.service':
    source => 'puppet:///modules/tic/usr/lib/systemd/system/tomcat.service',
  } ->
  service { 'tomcat-ipaas-srv':
    ensure   => $tic::frontend::params::tomcat_service_ensure,
    enable   => $tic::frontend::params::tomcat_service_enable,
    provider => 'systemd',
  }

}
