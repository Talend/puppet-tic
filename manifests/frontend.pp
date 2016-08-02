#this is the main class for the frontend role
class tic::frontend (

  $java_home                    = undef,
  $java_xmx                     = undef,
  $version                      = undef,
  $elasticache_address          = undef,
  $web_enable_test_context      = undef,
  $web_use_ssl                  = undef,
  $tomcat_service_ensure        = undef,
  $cms_node                     = undef,
  $s3_download_contentfile_name = undef,

  $workspace_url   = undef,
  $marketplace_url = undef,

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

  $web_samples_account_name   = undef,
  $web_samples_workspace_type = undef,

  $flow_manager_url               = undef,
  $crypto_service_url             = undef,
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
