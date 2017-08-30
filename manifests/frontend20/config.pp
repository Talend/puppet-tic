class tic::frontend20::config {

  require ::tic::frontend::install

  tic::ini_settings {

    'ipaas_webapp_server_settings':
      path     => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties',
      settings => {
        'scim_service_url'           => $tic::frontend20::params::scim_service_url,
        'crypto_tpsvc_service_url'   => $tic::frontend20::params::crypto_service_url,
        'config_tpsvc_service_url'   => $tic::frontend20::params::config_tpsvc_service_url,
        'logquery_tpsvc_service_url' => $tic::frontend20::params::logquery_tpsvc_service_url,
      };

    'ipaas_api_scim_settings':
      path     => '/srv/tomcat/ipaas-srv/webapps/api/WEB-INF/classes/ipaas_api.properties',
      settings => {
        'scim_service_url'                        => $tic::frontend20::params::scim_service_url,
        'security.oauth2.client.client_id'        => $tic::frontend20::params::basic_auth_oidc_clientId,
        'security.oauth2.client.client_secret'    => $tic::frontend20::params::basic_auth_oidc_clientSecret,
        'security.oauth2.client.access_token_uri' => "${tic::frontend20::params::iam_oidc_back_url}/oauth2/token",
        'security.oauth2.resource.token_info_uri' => "${tic::frontend20::params::iam_oidc_back_url}/oauth2/introspect",
        'iam.scim.url'                            => $tic::frontend20::params::scim_service_url
      };

    'ipaas_services_scim_settings':
      path     => '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/config.properties',
      settings => {
        'scim_service_url'                        => $tic::frontend20::params::scim_service_url,
        'security.oauth2.client.client_id'        => $tic::frontend20::params::basic_auth_oidc_clientId,
        'security.oauth2.client.client_secret'    => $tic::frontend20::params::basic_auth_oidc_clientSecret,
        'security.oauth2.client.access_token_uri' => "${tic::frontend20::params::iam_oidc_back_url}/oauth2/token",
        'security.oauth2.resource.token_info_uri' => "${tic::frontend20::params::iam_oidc_back_url}/oauth2/introspect",
        'iam.scim.url'                            => $tic::frontend20::params::scim_service_url
      };

    'ipaas_application_properties':
      path     => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/classes/application_properties',
      settings => {
        'security.oauth2.client.clientId'               => $tic::frontend20::params::client_app_oidc_clientId,
        'security.oauth2.client.clientSecret'           => $tic::frontend20::params::client_app_oidc_clientSecret,
        'security.oauth2.client.user-authorization-uri' => "${tic::frontend20::params::iam_oidc_front_url}/idp/authorize",
        'security.oidc.client.endSessionEndpoint'       => "${tic::frontend20::params::iam_oidc_front_url}/idp/logout",
        'security.oidc.client.keyUri'                   => "${tic::frontend20::params::iam_oidc_back_url}/jwk/keys",
        'security.oauth2.client.access-token-uri'       => "${tic::frontend20::params::iam_oidc_back_url}/oauth2/token",
        'security.oauth2.resource.tokenInfoUri'         => "${tic::frontend20::params::iam_oidc_back_url}/oauth2/introspect",
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

    'client application user authorization uri':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/classes/application.yml',
      line   => "      user-authorization-uri: ${tic::frontend20::params::iam_oidc_front_url}/idp/authorize",
      match  => '^[ ]{6}user-authorization-uri:';

    'client application user logout uri':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/classes/application.yml',
      line   => "      endSessionEndpoint: ${tic::frontend20::params::iam_oidc_front_url}/idp/logout",
      match  => '^[ ]{6}endSessionEndpoint:';

    'client application oidc key uri':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/classes/application.yml',
      line   => "      keyUri: ${tic::frontend20::params::iam_oidc_back_url}/jwk/keys",
      match  => '^[ ]{6}keyUri:';

    'client application access token uri':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/classes/application.yml',
      line   => "      access-token-uri: ${tic::frontend20::params::iam_oidc_back_url}/oauth2/token",
      match  => '^[ ]{6}access-token-uri:';

    'client application token info uri':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/classes/application.yml',
      line   => "      tokenInfoUri: ${tic::frontend20::params::iam_oidc_back_url}/oauth2/introspect",
      match  => '^[ ]{6}tokenInfoUri:';

    'server application clientId':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/application.yml',
      line   => "      clientId: ${tic::frontend20::params::server_app_oidc_clientId}",
      match  => '^[ ]{6}clientId:';

    'server application clientSecret':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/application.yml',
      line   => "      clientSecret: ${tic::frontend20::params::server_app_oidc_clientSecret}",
      match  => '^[ ]{6}clientSecret:';

    'server application oidc key uri':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/application.yml',
      line   => "      keyUri: ${tic::frontend20::params::iam_oidc_back_url}/jwk/keys",
      match  => '^[ ]{6}keyUri:';

    'server application token info uri':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/application.yml',
      line   => "      tokenInfoUri: ${tic::frontend20::params::iam_oidc_back_url}/oauth2/introspect",
      match  => '^[ ]{6}tokenInfoUri:';

    'server application scim uri':
      ensure => present,
      path   => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/application.yml',
      line   => "    url: ${tic::frontend20::params::scim_service_url}",
      match  => '^[ ]{4}url:';
  }

  $workspace_url    = $tic::frontend20::params::workspace_url
  $marketplace_url  = $tic::frontend20::params::marketplace_url
  $portal_url       = $tic::frontend20::params::portal_url
  $tdp_url          = $tic::frontend20::params::tdp_url
  $tmc_url          = $tic::frontend20::params::tmc_url
  $help_url         = $tic::frontend20::params::help_url
  $tcomp_static_ips = regsubst($tic::frontend20::params::tcomp_static_ips, '[\s\[\]\"]', '', 'G')

  file { '/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js':
    content => template('tic/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js.erb');
  }

  ini_setting { '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties-frontend20-marketplace_service_url':
      ensure  => present,
      path    => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties',
      section => '',
      setting => 'marketplace_service_url',
      value   => "${marketplace_url}/api/"
  }

}
