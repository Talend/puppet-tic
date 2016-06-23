class tic::frontend::config {

  $workspace_url       = $tic::workspace_url
  $marketplace_url     = $tic::marketplace_url
  $elasticache_address = pick($tic::elasticache_address, false)
  $web_enable_test_context = $tic::web_enable_test_context
  $web_use_ssl = $tic::web_use_ssl

  $tomcat_service_ensure = $tic::karaf_service_ensure
  validate_bool($web_enable_test_context)
  validate_bool($web_use_ssl)
  validate_re($marketplace_url, $tic::url_re, "marketplace url is not valid url. ${marketplace_url}")
  validate_re($tic::flow_manager_url, $tic::url_re, "flow manager url is not valid url. ${tic::flow_manager_url}")
  validate_re($tic::crypto_service_url, $tic::url_re, "crypto service url is not valid url. ${tic::crypto_service_url}")
  validate_re($tic::artifact_manager_url, $tic::url_re, "artifact manager service url is not valid url. ${tic::artifact_manager_url}")
  validate_re($tic::ams_url, $tic::url_re, "account manager service url is not valid url. ${tic::ams_url}")
  validate_re($tic::flow_execution_log_service_url, $tic::url_re, "elasticsearch  url is not valid url. ${tic::flow_execution_log_service_url}")
  validate_re($tic::ams_syncope_url, $tic::url_re, "syncope  url is not valid url. ${tic::ams_syncope_url}")
  validate_re($tic::cms_url, $tic::url_re, "container management service url is not valid url. ${tic::cms_url}")
  validate_re($tic::webhooks_service_url, $tic::url_re, "webhooks_service url is not valid url. ${tic::webhooks_service_url}")
  validate_re($tic::pe_service_url, $tic::url_re, "pe_service url is not valid url. ${tic::pe_service_url}")
  validate_re($tic::custom_resources_url, $tic::url_re, "custom_resources url is not valid url. ${tic::custom_resources_url}")
  validate_re($tic::notifier_service_url, $tic::url_re, "notification service url is not valid url. ${tic::notifier_service_url}")

  $ipaas_server_properties   = '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties'
  $ipaas_services_properties = '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/config.properties'

  Ini_setting {
    notify => Service['tomcat-ipaas-srv']

  }

  # The service resource is in the config.pp due to dependency cycles of with file resources in $base/conf
  tomcat::instance {
    'ipaas-srv':
      ensure       => $tomcat_service_ensure,
      java_home    => $tic::java_home,
      http_port    => '8081',
      http_address => '127.0.0.1',
      ajp_address  => '127.0.0.1',
      setenv       => [
        "JAVA_XMX=${tic::java_xmx}m",
        'ADD_JAVA_OPTS=-Djava.security.auth.login.config=$CATALINA_BASE/conf/jaas-ipaas-services.conf'
      ]
  }

  # the upstream puppet doesn't seems to do what it's supposed to do so we
  # patchit up with the ini settings
  ini_setting {

    'java_opts':
      ensure  => present,
      path    => '/etc/sysconfig/tomcat-ipaas-srv',
      section => '',
      setting => 'JAVA_OPTS',
      key_val_separator => '=',
      value   => "\"-Djava.security.auth.login.config=/srv/tomcat/ipaas-srv/conf/jaas-ipaas-services.conf -Xmx${tic::java_xmx}m -XX:MaxPermSize=256m\"";

    'java_home':
      ensure  => present,
      path    => '/etc/sysconfig/tomcat-ipaas-srv',
      section => '',
      setting => 'JAVA_HOME',
      key_val_separator => '=',
      value   => $tic::java_home;
  }

  file {
    '/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js':
      content => template('tic/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js.erb');

    '/srv/tomcat/ipaas-srv/conf/jaas-ipaas-services.conf':
      content => template('tic/srv/tomcat/ipaas-srv/conf/jaas-ipaas-services.conf.erb'),
      notify => Service['tomcat-ipaas-srv'];

    '/srv/tomcat/ipaas-srv/conf/jaas-ipaas-server.conf':
      content => template('tic/srv/tomcat/ipaas-srv/conf/jaas-ipaas-server.conf.erb'),
      notify => Service['tomcat-ipaas-srv'];

    '/srv/tomcat/ipaas-srv/webapps/ipaas-server/META-INF/context.xml':
      content => template('tic/srv/tomcat/ipaas-srv/webapps/ipaas-server/META-INF/context.xml.erb'),
      notify => Service['tomcat-ipaas-srv'];

    '/srv/tomcat/ipaas-srv/webapps/ROOT':
      ensure => link,
      target => '/srv/tomcat/ipaas-srv/webapps/ipaas'
  }

  if $web_enable_test_context {
    file {
      '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/conf/application-context.xml':
        source => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/conf/application-context-test.xml',
        notify => Service['tomcat-ipaas-srv'];

      '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/inventory-service.xml':
        source => '/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/inventory-service-test.xml',
        notify => Service['tomcat-ipaas-srv'];

    }

    file_line {
      'log4jdebug':
        path  => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/log4j.xml',
        line  => '<priority value="debug" />',
        match => '<priority value=".*"    />'
    }
  }

  ini_setting {

    'container_management_service_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'container_management_url',
      value   => $tic::cms_url;

    'flow_manager_url_server':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'flow_manager_url',
      value   => $tic::flow_manager_url;

    'artifact_manager_url_services':
      ensure  => present,
      path    => $ipaas_services_properties,
      section => '',
      setting => 'artifact_manager_url',
      value   => $tic::artifact_manager_url;

    'artifact_manager_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'artifact_manager_url',
      value   => $tic::artifact_manager_url;

    'crypto_service_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'crypto_service_url',
      value   => $tic::crypto_service_url;

    'account_manager_service_url_server':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'account_manager_url',
      value   => $tic::ams_url;

    'account_manager_service_url_services':
      ensure  => present,
      path    => $ipaas_services_properties,
      section => '',
      setting => 'account_manager_url',
      value   => $tic::ams_url;

    'flow_execution_log_service_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'flow_execution_log_service_url',
      value   => $tic::flow_execution_log_service_url;

    'marketplace_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'marketplace_service_url',
      value   => "${tic::marketplace_url}/api/";

    'data_prep_service_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'data_prep_service_url',
      value   => $tic::data_prep_service_url;

    'data_transfer_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'data_transfer_url',
      value   => $tic::dts_service_url;

    'schema_discovery_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'schema_discovery_url',
      value   => $tic::schema_discovery_service_url;

    'trial_registration_service_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'trial_registration_service_url',
      value   => $tic::trial_service_url;

    'web_samples_account_name':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'samples_account_name',
      value   => $tic::web_samples_account_name;

    'web_samples_workspace_type':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'samples_workspace_type',
      value   => $tic::web_samples_workspace_type;

    'custom_resources_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'custom_resources_url',
      value   => $tic::custom_resources_url;

    'plan_executor_service_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'plan_executor_service_url',
      value   => $tic::pe_service_url;

    'webhooks_service_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'webhooks_service_url',
      value   => $tic::webhooks_service_url;

    'notifier_service_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'notifier_service_url',
      value   => $tic::notifier_service_url;

    'notification_subscription_service_url':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'notification_subscription_service_url',
      value   => $tic::notification_subscription_url;

    's3_download_contentfile_name':
      ensure  => present,
      path    => $ipaas_server_properties,
      section => '',
      setting => 'downloads_config',
      value   => $tic::s3_download_contentfile_name;
  }

  if $::t_environment == 'dv' and $::t_subenv != 'build' {
    $index_file = 'index.jsp'
  } else {
    $index_file = 'index-min.jsp'
  }


  file_line {
    'web_use_ssl':
      path => '/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/web.xml',
      line => "<secure>${web_use_ssl}</secure>",
      match => '<secure>(true)|(false)</secure>';

    'web_use_mini_js':
      path  => '/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/web.xml',
      line  => "<welcome-file>${index_file}</welcome-file>",
      match => '<welcome-file>',
      notify => Service['tomcat-ipaas-srv'];
  }

}

