class tic::frontend::config {

  require ::tic::frontend::install

  $workspace_url           = $tic::frontend::params::workspace_url
  $marketplace_url         = $tic::frontend::params::marketplace_url
  $elasticache_address     = $tic::frontend::params::elasticache_address
  $elasticache_port        = $tic::frontend::params::elasticache_port
  $tomcat_service_ensure   = $tic::frontend::params::tomcat_service_ensure
  $sts_host                = $tic::frontend::params::sts_host
  $sts_username            = $tic::frontend::params::sts_username
  $sts_password            = $tic::frontend::params::sts_password
  $web_enable_test_context = $tic::frontend::params::web_enable_test_context
  $web_use_ssl             = $tic::frontend::params::web_use_ssl

  validate_bool($web_enable_test_context)
  validate_bool($web_use_ssl)

  file {
    '/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js':
      content => template('tic/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js.erb');

    '/srv/tomcat/ipaas-srv/conf/jaas-ipaas-services.conf':
      content => template('tic/srv/tomcat/ipaas-srv/conf/jaas-ipaas-services.conf.erb');

    '/srv/tomcat/ipaas-srv/conf/jaas-ipaas-server.conf':
      content => template('tic/srv/tomcat/ipaas-srv/conf/jaas-ipaas-server.conf.erb');

    '/srv/tomcat/ipaas-srv/webapps/ipaas-server/META-INF/context.xml':
      content => template('tic/srv/tomcat/ipaas-srv/webapps/ipaas-server/META-INF/context.xml.erb');

    '/srv/tomcat/ipaas-srv/webapps/ROOT':
      ensure => link,
      target => '/srv/tomcat/ipaas-srv/webapps/ipaas'
  }

  if $web_enable_test_context {
    file {
      '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/conf/application-context.xml':
        source => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/conf/application-context-test.xml';

      '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/inventory-service.xml':
        source => '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/inventory-service-test.xml';
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
      'crypto_service_url'                    => $tic::frontend::params::crypto_service_url,
      'account_manager_url'                   => $tic::frontend::params::ams_url,
      'flow_execution_log_service_url'        => $tic::frontend::params::flow_execution_log_service_url,
      'marketplace_service_url'               => "${marketplace_url}/api/",
      'data_prep_service_url'                 => $tic::frontend::params::data_prep_service_url,
      'data_transfer_url'                     => $tic::frontend::params::dts_service_url,
      'schema_discovery_url'                  => $tic::frontend::params::schema_discovery_service_url,
      'trial_registration_service_url'        => $tic::frontend::params::trial_service_url,
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
      'memcached.addresses'                   => "${tic::frontend::params::elasticache_address}:${tic::frontend::params::elasticache_port}",
    }
  }

  # ipaas-services
  tic::ini_settings { '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/config.properties':
    settings => {
      'account_manager_url'       => $tic::frontend::params::ams_url,
      'artifact_manager_url'      => $tic::frontend::params::artifact_manager_url,
      'custom_resources_url'      => $tic::frontend::params::custom_resources_url,
      'custom_resources_username' => $tic::frontend::params::custom_resources_username,
      'custom_resources_password' => $tic::frontend::params::custom_resources_password,
    }
  }

  # ipaas-api
  tic::ini_settings { '/srv/tomcat/ipaas-srv/webapps/api/WEB-INF/classes/ipaas_api.properties':
    settings => {
      'account_manager_url' => $tic::frontend::params::ams_url,
      'flow_manager_url'    => $tic::frontend::params::flow_manager_url,
    }
  }

  if $::t_environment == 'dv' and $::t_subenv != 'build' {
    $index_file = 'index.jsp'
  } else {
    $index_file = 'index-min.jsp'
  }

  file_line {
    'web_use_ssl':
      path  => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/web.xml',
      line  => "<secure>${web_use_ssl}</secure>",
      match => '<secure>(true)|(false)</secure>';

    'web_use_mini_js':
      path  => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/web.xml',
      line  => "<welcome-file>${index_file}</welcome-file>",
      match => '<welcome-file>';
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

}
