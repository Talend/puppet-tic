class tic::frontend::service {

  file { '/usr/lib/systemd/system/tomcat-ipaas-srv.service':
    source => 'puppet:///modules/tic/usr/lib/systemd/system/tomcat.service',
  } ->
  service { 'tomcat-ipaas-srv':
    ensure   => running,
    enable   => true,
    provider => 'systemd',
  }

}
