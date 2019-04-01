#this is the main class for the frontend role
class tic::frontend (

  $java_home                    = undef,
  $java_xmx                     = undef,
  $java_max_metaspace_size      = undef,
  $version                      = undef,
  $web_enable_test_context      = undef,
  $web_use_ssl                  = undef,
  $tomcat_service_ensure        = undef,
  $tomcat_service_enable        = undef,
  $ipaas_srv_http_port          = undef,
  $cms_node                     = undef,
  $s3_download_contentfile_name = undef,

  $redis_session_host      = undef,
  $redis_session_port      = undef,
  $redis_session_namespace = undef,

  $ams_syncope_host = undef,

  $sts_host     = undef,
  $sts_username = undef,
  $sts_password = undef,

  $elasticsearch_host = undef,
  $elasticsearch_port = undef,

  $flow_manager_nodes              = undef,
  $crypto_service_nodes            = undef,
  $artifact_manager_nodes          = undef,
  $account_manager_nodes           = undef,
  $webhooks_service_nodes          = undef,
  $pe_service_nodes                = undef,
  $custom_resources_nodes          = undef,
  $notifier_service_nodes          = undef,
  $data_prep_service_nodes         = undef,
  $dts_service_node                = undef,
  $schema_discovery_service_nodes  = undef,
  $trial_service_nodes             = undef,
  $notification_subscription_nodes = undef,
  $logs_log_transfer_service_nodes = undef,

  $web_samples_account_name   = undef,
  $web_samples_workspace_type = undef,

  $flow_manager_url               = undef,
  $artifact_manager_url           = undef,
  $ams_url                        = undef,
  $flow_execution_log_service_url = undef,
  $ams_syncope_url                = undef,
  $cms_url                        = undef,
  $webhooks_service_url           = undef,
  $pe_service_url                 = undef,
  $custom_resources_url           = undef,
  $notifier_service_url           = undef,
  $data_prep_service_url          = undef,
  $dts_service_url                = undef,
  $schema_discovery_service_url   = undef,
  $trial_service_url              = undef,
  $notification_subscription_url  = undef,
  $logs_log_transfer_service_url  = undef,

  $custom_resources_username = undef,
  $custom_resources_password = undef,

  $scim_service_node = undef,
  $scim_service_url  = undef,

  $client_app_oidc_clientId      = undef,
  $client_app_oidc_clientSecret  = undef,
  $server_app_oidc_clientId      = undef,
  $server_app_oidc_clientSecret  = undef,
  $crypto_service_url            = undef,
  $config_tpsvc_service_url      = undef,
  $logquery_tpsvc_service_url    = undef,
  $dss_streams_runner_logs_url   = undef,

  $iam_oidc_front_url = undef,
  $iam_oidc_back_url = undef,

  $basic_auth_oidc_clientId      = undef,
  $basic_auth_oidc_clientSecret  = undef,

  $workspace_url   = undef,
  $marketplace_url = undef,
  $portal_url      = undef,
  $tdp_url         = undef,
  $tds_url         = undef,
  $tmc_url         = undef,
  $dss_url         = undef,
  $help_url        = undef,

  $tcomp_static_ips = undef,

  $pendo_enabled        = undef,
  $pendo_ipaas_key      = undef,
  $pendo_cloud_provider = undef,
  $pendo_region         = undef,

  $zipkin_enabled       = undef,
  $zipkin_kafka_topic   = undef,
  $zipkin_kafka_servers = undef,
  $zipkin_sampling_rate = undef,

) {

  contain ::tic::frontend::params

  class { '::tic::common':
    java_home => $tic::frontend::params::java_home
  }

  contain ::tic::frontend::install
  contain ::tic::frontend::config
  contain ::tic::frontend::service

  Class['::tic::frontend::params'] ~>
  Class['::tic::common'] ~>
  Class['::tic::frontend::install'] ~>
  Class['::tic::frontend::config'] ~>
  Class['::tic::frontend::service']

}
