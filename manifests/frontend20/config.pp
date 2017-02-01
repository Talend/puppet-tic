class tic::frontend20::config {

  require ::tic::frontend::install

  tic::ini_settings { 'scim_service_url':
    path     => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties',
    settings => {
      'scim_service_url'   => "http://${tic::frontend20::scim_service_node}"
    }
  }
}
