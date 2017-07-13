class tic::frontend18::config {

  require ::tic::frontend::install

  $workspace_url    = $tic::frontend18::params::workspace_url
  $marketplace_url  = $tic::frontend18::params::marketplace_url
  $help_url         = $tic::frontend18::params::help_url
  $tcomp_static_ips = ''

  file { '/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js':
    content => template('tic/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js.erb');
  }

  ini_setting { '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties-frontend18-marketplace_service_url':
      ensure  => present,
      path    => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties',
      section => '',
      setting => 'marketplace_service_url',
      value   => "${marketplace_url}/api/"
  }

}
