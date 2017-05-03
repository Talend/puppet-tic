class tic::frontend20::config {

  require ::tic::frontend::install

  tic::ini_settings {
    'ipaas_webapp_server_settings':
      path     => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties',
      settings => {
        'scim_service_url'         => $tic::frontend20::params::scim_service_url,
        'crypto_tpsvc_service_url' => $tic::frontend20::params::crypto_service_url
      };

    'ipaas_api_scim_service_url':
      path     => '/srv/tomcat/ipaas-srv/webapps/api/WEB-INF/classes/ipaas_api.properties',
      settings => {
        'scim_service_url'   => $tic::frontend20::params::scim_service_url,
      };
    'ipaas_services_scim_service_url':
      path     => '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/config.properties',
      settings => {
        'scim_service_url'   => $tic::frontend20::params::scim_service_url,
      };
  }

  file_line {
    'client application clientId':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/classes/application.yml',
      line   => "      clientId: ${tic::frontend20::params::client_app_oidc_clientId}",
      match  => '^[ ]{6}clientId:';

    'client application clientSecret':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/classes/application.yml',
      line   => "      clientSecret: ${tic::frontend20::params::client_app_oidc_clientSecret}",
      match  => '^[ ]{6}clientSecret:';

    'server application clientId':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/application.yml',
      line   => "      clientId: ${tic::frontend20::params::server_app_oidc_clientId}",
      match  => '^[ ]{6}clientId:';

    'server application clientSecret':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/application.yml',
      line   => "      clientSecret: ${tic::frontend20::params::server_app_oidc_clientSecret}",
      match  => '^[ ]{6}clientSecret:'
  }
}
