class tic::frontend20::config {

  require ::tic::frontend::install

  tic::ini_settings { 'ipaas_scim_service_url':
    path     => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties',
    settings => {
      'scim_service_url'   => "http://${tic::frontend20::scim_service_node}"
    }
  }

  tic::ini_settings { 'ipaas_api_scim_service_url':
    path     => '/srv/tomcat/ipaas-srv/webapps/api/WEB-INF/classes/ipaas_api.properties',
    settings => {
      'scim_service_url'   => "http://${tic::frontend20::scim_service_node}"
    }
  }

  tic::ini_settings { 'ipaas_services_scim_service_url':
    path     => '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/config.properties',
    settings => {
      'scim_service_url'   => "http://${tic::frontend20::scim_service_node}"
    }
  }
}
