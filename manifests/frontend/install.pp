class tic::frontend::install {

  Exec {
    path => '/usr/bin:/usr/sbin/:/bin:/sbin:/usr/local/bin:/usr/local/sbin',
  }

  file {
    '/etc/sysconfig/tomcat':
      ensure => present;

    '/usr/lib/systemd/system/tomcat.service':
      source => 'puppet:///modules/tic/usr/lib/systemd/system/tomcat.service';

    '/etc/rsyslog.d/tomcat-ipaas-srv.conf':
      content => ':programname,contains,"catalina" /srv/tomcat/ipaas-srv/logs/catalina.out'
  } ->
  class { 'tomcat':
    version    => 8,
    srcversion => '8.0.33',
    sources    => true,
    require    => File['/etc/sysconfig/tomcat']
  }

  package {
    'talend-ipaas-web':
      ensure => $tic::version;

    'talend-ipaas-web-admin':
      ensure => absent;

    'talend-ipaas-web-services':
      ensure => $tic::version;

    'talend-ipaas-web-server':
      ensure => $tic::version;

    'talend-ipaas-web-memcache-libs':
      ensure  => '0.2-2', # version with timcat8 libraries
      require => Package['talend-ipaas-web-server']
  }

}
