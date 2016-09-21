class tic::frontend::params {

  $tomcat_service_ensure = $::t_subenv ? {
    build   => stopped,
    default => pick($tic::frontend::tomcat_service_ensure, running)
  }

  $java_home = pick($tic::frontend::java_home, undef)
  $java_xmx  = pick($tic::frontend::java_xmx,  '1024')
  $version   = pick($tic::frontend::version,   'latest')

  $elasticache_address          = pick($tic::frontend::elasticache_address,          false)
  $elasticache_port             = pick($tic::frontend::elasticache_port,             '11211')
  $web_enable_test_context      = pick($tic::frontend::web_enable_test_context,      false)
  $web_use_ssl                  = pick($tic::frontend::web_use_ssl,                  true)
  $cms_node                     = pick($tic::frontend::cms_node,                     'localhost')
  $s3_download_contentfile_name = pick($tic::frontend::s3_download_contentfile_name, 'downloads/config/downloads.json')

  $workspace_url   = pick($tic::frontend::workspace_url,   '/ipaas-server/services')
  $marketplace_url = pick($tic::frontend::marketplace_url, 'https://exchange.talend.com')

  $ams_syncope_host     = pick($tic::frontend::ams_syncope_host,     'missing')
  $ams_syncope_username = pick($tic::frontend::ams_syncope_username, 'tadmin')
  $ams_syncope_password = pick($tic::frontend::ams_syncope_password, 'missing')

  $sts_host     = pick($tic::frontend::sts_host,     $ams_syncope_host)
  $sts_username = pick($tic::frontend::sts_username, $ams_syncope_username)
  $sts_password = pick($tic::frontend::sts_password, $ams_syncope_password)

  $elasticsearch_host = pick($tic::frontend::elasticsearch_host, 'localhost')
  $elasticsearch_port = pick($tic::frontend::elasticsearch_port, '8080')

  $account_manager_nodes           = pick($tic::frontend::account_manager_nodes,           'localhost')
  $artifact_manager_nodes          = pick($tic::frontend::artifact_manager_nodes,          'localhost')
  $crypto_service_nodes            = pick($tic::frontend::crypto_service_nodes,            'localhost')
  $custom_resources_nodes          = pick($tic::frontend::custom_resources_nodes,          'localhost')
  $data_prep_service_nodes         = pick($tic::frontend::data_prep_service_nodes,         'localhost')
  $dts_service_node                = pick($tic::frontend::dts_service_node,                $::hostname)
  $flow_manager_nodes              = pick($tic::frontend::flow_manager_nodes,              'localhost')
  $notification_subscription_nodes = pick($tic::frontend::notification_subscription_nodes, 'localhost')
  $notifier_service_nodes          = pick($tic::frontend::notifier_service_nodes,          'localhost')
  $pe_service_nodes                = pick($tic::frontend::pe_service_nodes,                'localhost')
  $schema_discovery_service_nodes  = pick($tic::frontend::schema_discovery_service_nodes,  'localhost')
  $trial_service_nodes             = pick($tic::frontend::trial_service_nodes,             'localhost')
  $webhooks_service_nodes          = pick($tic::frontend::webhooks_service_nodes,          'localhost')

  $web_samples_account_name   = pick($tic::frontend::web_samples_account_name,   'examples.talend.com')
  $web_samples_workspace_type = pick($tic::frontend::web_samples_workspace_type, 'Shared')

  $ams_syncope_url                = pick($tic::frontend::ams_syncope_url,                inline_template('http://<%= @ams_syncope_host %>:8080/syncope/rest'))
  $ams_url                        = pick($tic::frontend::ams_url,                        inline_template('http://<%= @account_manager_nodes.split(",")[0] %>:8181/services/account-management-service'))
  $artifact_manager_url           = pick($tic::frontend::artifact_manager_url,           inline_template('http://<%= @artifact_manager_nodes.split(",")[0] %>:8181/services/artifact-manager-service'))
  $cms_url                        = pick($tic::frontend::cms_url,                        "http://${cms_node}:8181/services/container-management-service")
  $crypto_service_url             = pick($tic::frontend::crypto_service_url,             inline_template('http://<%= @crypto_service_nodes.split(",")[0] %>:8181/services/crypto-service'))
  $custom_resources_url           = pick($tic::frontend::custom_resources_url,           inline_template('http://<%= @custom_resources_nodes.split(",")[0] %>:8181/services/custom-resources'))
  $data_prep_service_url          = pick($tic::frontend::data_prep_service_url,          inline_template('<%= @data_prep_service_nodes.split(",").map { |a| "http://"+a+":8080/datasets" }.join(",") %>'))
  $dts_service_url                = pick($tic::frontend::dts_service_url,                inline_template('http://<%= @dts_service_node %>:8181/services/data-transfer-service'))
  $flow_execution_log_service_url = pick($tic::frontend::flow_execution_log_service_url, "http://${elasticsearch_host}:${elasticsearch_port}/")
  $flow_manager_url               = pick($tic::frontend::flow_manager_url,               inline_template('http://<%= @flow_manager_nodes.split(",")[0] %>:8181/services/flow-manager-service'))
  $notification_subscription_url  = pick($tic::frontend::notification_subscription_url,  inline_template('http://<%= @notification_subscription_nodes.split(",")[0] %>:8181/services/notification-subscription'))
  $notifier_service_url           = pick($tic::frontend::notifier_service_url,           inline_template('http://<%= @notifier_service_nodes.split(",")[0] %>:8181/services/notifier-service'))
  $pe_service_url                 = pick($tic::frontend::pe_service_url,                 inline_template('http://<%= @pe_service_nodes.split(",")[0] %>:8181/services/plan-executor-service'))
  $schema_discovery_service_url   = pick($tic::frontend::schema_discovery_service_url,   inline_template('http://<%= @schema_discovery_service_nodes.split(",")[0] %>:8181/services/schema-discovery-service'))
  $trial_service_url              = pick($tic::frontend::trial_service_url,              inline_template('http://<%= @trial_service_nodes.split(",")[0] %>:8181/services/trial-registration-service'))
  $webhooks_service_url           = pick($tic::frontend::webhooks_service_url,           inline_template('http://<%= @webhooks_service_nodes.split(",")[0] %>:8181/services/webhooks-service'))

  $custom_resources_username = pick($tic::frontend::custom_resources_username, 'tadmin')
  $custom_resources_password = pick($tic::frontend::custom_resources_password, 'missing')

}
