class tic::frontend::config {

  require ::tic::frontend::install

  $tomcat_service_ensure   = $tic::frontend::params::tomcat_service_ensure
  $sts_host                = $tic::frontend::params::sts_host
  $sts_username            = $tic::frontend::params::sts_username
  $sts_password            = $tic::frontend::params::sts_password
  $web_enable_test_context = $tic::frontend::params::web_enable_test_context
  $web_use_ssl             = $tic::frontend::params::web_use_ssl

  validate_bool($web_enable_test_context)
  validate_bool($web_use_ssl)

  if $web_enable_test_context {
    file { '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/conf/application-context.xml':
        source => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/conf/application-context-test.xml'
    }

    exec { 'create inventory-context.xml':
      command => 'cp \
      /srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/inventory-service-test.xml \
      /srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/inventory-service.xml',
      creates => '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/inventory-service.xml',
      path    => ['/usr/bin', '/usr/sbin']
    }

    file_line {
      'log4jdebug':
        path  => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/log4j.xml',
        line  => '<priority value="debug" />',
        match => '<priority value=".*"    />'
    }
  }

  # ipaas-server
  tic::ini_settings { '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties':
    settings => {
      'container_management_url'              => $tic::frontend::params::cms_url,
      'flow_manager_url'                      => $tic::frontend::params::flow_manager_url,
      'artifact_manager_url'                  => $tic::frontend::params::artifact_manager_url,
      'account_manager_url'                   => $tic::frontend::params::ams_url,
      'data_prep_service_url'                 => $tic::frontend::params::data_prep_service_url,
      'data_transfer_url'                     => $tic::frontend::params::dts_service_url,
      'schema_discovery_url'                  => $tic::frontend::params::schema_discovery_service_url,
      'samples_account_name'                  => $tic::frontend::params::web_samples_account_name,
      'samples_workspace_type'                => $tic::frontend::params::web_samples_workspace_type,
      'custom_resources_url'                  => $tic::frontend::params::custom_resources_url,
      'custom_resources_username'             => $tic::frontend::params::custom_resources_username,
      'custom_resources_password'             => $tic::frontend::params::custom_resources_password,
      'plan_executor_service_url'             => $tic::frontend::params::pe_service_url,
      'webhooks_service_url'                  => $tic::frontend::params::webhooks_service_url,
      'notifier_service_url'                  => $tic::frontend::params::notifier_service_url,
      'notification_subscription_service_url' => $tic::frontend::params::notification_subscription_url,
      'downloads_config'                      => $tic::frontend::params::s3_download_contentfile_name,
      'log_transfer_service_url'              => $tic::frontend::params::logs_log_transfer_service_url,
      'scim_service_url'                      => $tic::frontend::params::scim_service_url,
      'crypto_tpsvc_service_url'              => $tic::frontend::params::crypto_service_url,
      'config_tpsvc_service_url'              => $tic::frontend::params::config_tpsvc_service_url,
      'logquery_tpsvc_service_url'            => $tic::frontend::params::logquery_tpsvc_service_url,
      'marketplace_service_url'               => "${tic::frontend::params::marketplace_url}/api/",
      'dss_streams_runner_logs_url'           => "http://back.tpd${tic::frontend::params::internal_domain}",
    }
  }

  # ipaas-services
  tic::ini_settings { '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/application.properties':
    settings => {
      'workspace_service_url'                         => "http://localhost:${tic::frontend::params::ipaas_srv_http_port}/ipaas-server/services",
      'artifact_manager_url'                          => $tic::frontend::params::artifact_manager_url,
      'custom_resources_url'                          => $tic::frontend::params::custom_resources_url,
      'custom_resources_username'                     => $tic::frontend::params::custom_resources_username,
      'custom_resources_password'                     => $tic::frontend::params::custom_resources_password,
      'security.oauth2.client.clientId'               => $tic::frontend::params::basic_auth_oidc_clientId,
      'security.oauth2.client.clientSecret'           => $tic::frontend::params::basic_auth_oidc_clientSecret,
      'security.oauth2.client.access-token-uri'       => "${tic::frontend::params::iam_oidc_back_url}/oauth2/token",
      'security.oauth2.client.user-authorization-uri' => "${tic::frontend::params::iam_oidc_front_url}/idp/authorize",
      'security.oauth2.resource.tokenInfoUri'         => "${tic::frontend::params::iam_oidc_back_url}/oauth2/introspect",
      'iam.scim.url'                                  => $tic::frontend::params::scim_service_url,
      'spring.zipkin.enabled'                         => $tic::frontend::params::zipkin_enabled,
      'spring.zipkin.kafka.topic'                     => $tic::frontend::params::zipkin_kafka_topic,
      'spring.kafka.bootstrapServers'                 => $tic::frontend::params::zipkin_kafka_servers,
      'spring.sleuth.sampler.percentage'              => $tic::frontend::params::zipkin_sampling_rate
    }
  }

  # ipaas-api
  tic::ini_settings { '/srv/tomcat/ipaas-srv/webapps/api/WEB-INF/classes/application.properties':
    settings => {
      'ipaas_service_url'                             => "http://localhost:${tic::frontend::params::ipaas_srv_http_port}/ipaas-server/services",
      'flow_manager_url'                              => $tic::frontend::params::flow_manager_url,
      'security.oauth2.client.clientId'               => $tic::frontend::params::basic_auth_oidc_clientId,
      'security.oauth2.client.clientSecret'           => $tic::frontend::params::basic_auth_oidc_clientSecret,
      'security.oauth2.client.access-token-uri'       => "${tic::frontend::params::iam_oidc_back_url}/oauth2/token",
      'security.oauth2.client.user-authorization-uri' => "${tic::frontend::params::iam_oidc_front_url}/idp/authorize",
      'security.oauth2.resource.tokenInfoUri'         => "${tic::frontend::params::iam_oidc_back_url}/oauth2/introspect",
      'iam.scim.url'                                  => $tic::frontend::params::scim_service_url,
      'spring.zipkin.enabled'                         => $tic::frontend::params::zipkin_enabled,
      'spring.zipkin.kafka.topic'                     => $tic::frontend::params::zipkin_kafka_topic,
      'spring.kafka.bootstrapServers'                 => $tic::frontend::params::zipkin_kafka_servers,
      'spring.sleuth.sampler.percentage'              => $tic::frontend::params::zipkin_sampling_rate
    }
  }

  tic::ini_settings {

    'ipaas_application_properties':
      path     => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/classes/application.properties',
      settings => {
        'security.oauth2.client.clientId'               => $tic::frontend::params::client_app_oidc_clientId,
        'security.oauth2.client.clientSecret'           => $tic::frontend::params::client_app_oidc_clientSecret,
        'security.oauth2.client.user-authorization-uri' => "${tic::frontend::params::iam_oidc_front_url}/idp/authorize",
        'security.oidc.client.endSessionEndpoint'       => "${tic::frontend::params::iam_oidc_front_url}/idp/logout",
        'security.oidc.client.keyUri'                   => "${tic::frontend::params::iam_oidc_back_url}/jwk/keys",
        'security.oidc.client.expectedIssuer'           => $tic::frontend::params::iam_oidc_front_url,
        'security.oauth2.client.access-token-uri'       => "${tic::frontend::params::iam_oidc_back_url}/oauth2/token",
        'security.oauth2.resource.tokenInfoUri'         => "${tic::frontend::params::iam_oidc_back_url}/oauth2/introspect",
        # matches the last part of tic::frontend::redis_session_namespace
        'spring.session.redis.namespace'                => 'Tipaas',
        'spring.zipkin.enabled'                         => $tic::frontend::params::zipkin_enabled,
        'spring.zipkin.kafka.topic'                     => $tic::frontend::params::zipkin_kafka_topic,
        'spring.kafka.bootstrapServers'                 => $tic::frontend::params::zipkin_kafka_servers,
        'spring.sleuth.sampler.percentage'              => $tic::frontend::params::zipkin_sampling_rate
      };

    'ipaas_server_application_properties':
      path     => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/application.properties',
      settings => {
        'security.oauth2.client.clientId'       => $tic::frontend::params::server_app_oidc_clientId,
        'security.oauth2.client.clientSecret'   => $tic::frontend::params::server_app_oidc_clientSecret,
        'security.oidc.client.keyUri'           => "${tic::frontend::params::iam_oidc_back_url}/jwk/keys",
        'security.oauth2.resource.tokenInfoUri' => "${tic::frontend::params::iam_oidc_back_url}/oauth2/introspect",
        'iam.scim.url'                          => $tic::frontend::params::scim_service_url,
        'minConnectionsPerHost'                 => '0',
        'spring.zipkin.enabled'                 => $tic::frontend::params::zipkin_enabled,
        'spring.zipkin.kafka.topic'             => $tic::frontend::params::zipkin_kafka_topic,
        'spring.kafka.bootstrapServers'         => $tic::frontend::params::zipkin_kafka_servers,
        'spring.sleuth.sampler.percentage'      => $tic::frontend::params::zipkin_sampling_rate
      };

  }

  $workspace_url    = $tic::frontend::params::workspace_url
  $marketplace_url  = $tic::frontend::params::marketplace_url
  $portal_url       = $tic::frontend::params::portal_url
  $tdp_url          = $tic::frontend::params::tdp_url
  $tds_url          = $tic::frontend::params::tds_url
  $tmc_url          = $tic::frontend::params::tmc_url
  $dss_url          = $tic::frontend::params::dss_url
  $help_url         = $tic::frontend::params::help_url
  $tcomp_static_ips = regsubst($tic::frontend::params::tcomp_static_ips, '[\s\[\]\"]', '', 'G')

  $mixpanel_enabled     = $tic::frontend::params::mixpanel_enabled
  $mixpanel_ipaas_key   = $tic::frontend::params::mixpanel_ipaas_key
  $pendo_enabled        = $tic::frontend::params::pendo_enabled
  $pendo_ipaas_key      = $tic::frontend::params::pendo_ipaas_key
  $pendo_cloud_provider = $tic::frontend::params::pendo_cloud_provider
  $pendo_region         = $tic::frontend::params::pendo_region

  file { '/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js':
    content => template('tic/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js.erb');
  }

  if $::t_environment == 'dv' and $::t_subenv != 'build' {
    $index_file = 'index.jsp'
  } else {
    $index_file = 'index-min.jsp'
  }

  file_line { 'web_use_ssl':
    path  => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/web.xml',
    line  => "<secure>${web_use_ssl}</secure>",
    match => '<secure>(true)|(false)</secure>';
  }

  # parse aws account id for the tic_s3_access.template.erb template
  if $::ec2_metadata =~ /owner\-id\".*?\"(\d+)\"/ {
    $aws_account_id = $1
  } else {
    $aws_account_id = undef
  }

  file { '/srv/tomcat/ipaas-srv/webapps/ipaas/resources':
    ensure => directory,
  } ->
  file { '/srv/tomcat/ipaas-srv/webapps/ipaas/resources/tic_s3_access.template':
    content => template('tic/srv/tomcat/ipaas-srv/webapps/ipaas/resources/tic_s3_access.template.erb'),
  }

  file { '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes':
    ensure => directory,
  } ->
  file { '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/tic_s3_access.template':
    content => template('tic/srv/tomcat/ipaas-srv/webapps/ipaas/resources/tic_s3_access.template.erb'),
  }

  file_line { 'ipaas_post_publish_url_redirect':
    path  => '/srv/tomcat/ipaas-srv/webapps/tasks-and-plans-administration/redirect.jsp',
    line  => "String targetUrl = \"${tmc_url}\";",
    match => 'String targetUrl = "';
  }

}
