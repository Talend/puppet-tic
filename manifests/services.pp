class tic::services (

  $java_home = undef,
  $java_xmx  = undef,

  $manage_packages         = undef,
  $wrapper_diable_restarts = undef,
  $version                 = undef,
  $karaf_base_path         = undef,

  $karaf_service_ensure   = undef,
  $karaf_service_enable   = undef,
  $osgi_http_service_port = undef,

  $karaf_features_install = undef,

  $logging_level    = undef,
  $log_amq_messages = undef,

  $account_manager_nodes    = undef,
  $activemq_nodes           = undef,
  $ams_syncope_host         = undef,
  $artifact_manager_nodes   = undef,
  $bookkeeper_service_nodes = undef,
  $cms_node                 = undef,
  $config_service_node      = undef,
  $crypto_service_nodes     = undef,
  $dts_service_node         = undef,
  $lts_service_node         = undef,
  $flow_manager_nodes       = undef,
  $nexus_nodes              = undef,
  $pe_service_nodes         = undef,
  $postgres_nodes           = undef,
  $zookeeper_nodes          = undef,
  $mongo_nodes              = undef,

  $activemq_broker_username = undef,
  $activemq_broker_password = undef,
  $min_activemq_brokers     = undef,

  $elasticsearch_host = undef,
  $elasticsearch_port = undef,

  $activemq_broker_url    = undef,
  $ams_syncope_url        = undef,
  $ams_url                = undef,
  $artifact_manager_url   = undef,
  $bookkeeper_service_url = undef,
  $cms_amq_broker_url     = undef,
  $cms_dts_service_url    = undef,
  $cms_lts_service_url    = undef,
  $cms_nexus_url          = undef,
  $dispatcher_nexus_url   = undef,
  $cms_url                = undef,
  $config_service_url     = undef,
  $crypto_service_url     = undef,
  $dts_service_url        = undef,
  $lts_service_url        = undef,
  $flow_manager_url       = undef,
  $nexus_urls             = undef,
  $pe_service_url         = undef,

  $nexus_password       = undef,
  $nexus_min_host_count = undef,

  $mongo_admin_user      = undef,
  $mongo_admin_password  = undef,
  $mongo_db_name         = undef,

  $min_zookeeper_nodes   = undef,

  $config_db_host     = undef,
  $config_db_password = undef,

  $cms_db_host     = undef,
  $cms_db_password = undef,

  $ams_syncope_password = undef,

  $ams_mail_config_update_period   = undef,
  $ams_mail_config_password_reset  = undef,
  $ams_mail_config_user_created    = undef,
  $ams_password_reset_url_template = undef,
  $ams_current_region              = undef,
  $ams_disaster_region             = undef,

  $kms_key_alias            = undef,
  $crypto_current_region    = undef,
  $crypto_secondary_regions = undef,
  $crypto_db_host           = undef,
  $crypto_db_password       = undef,

  $cr_bucket_name                      = undef,
  $cr_object_key_prefix                = undef,
  $cr_presignedurl_upload_timetolive   = undef,
  $cr_presignedurl_download_timetolive = undef,
  $cr_size_limit_per_resource          = undef,
  $cr_size_limit_per_account           = undef,

  $dts_s3_bucket_rejected_data  = undef,
  $dts_s3_bucket_test_data      = undef,
  $dts_s3_bucket_logs_data      = undef,
  $dts_s3_bucket_downloads_data = undef,
  $dts_max_data_size            = undef,
  $dts_shared_secret            = undef,
  $dts_s3_prefix                = undef,

  $rt_aws_region                 = undef,
  $flow_undeploy_after_completed = undef,

  $notification_manager_input_queue       = undef,
  $notification_client_failures_log       = undef,
  $notification_manager_destination_queue = undef,

  $notification_server_sendgrid_api_key                      = undef,
  $notification_server_sendgrid_user_created                 = undef,
  $notification_server_sendgrid_user_deleted                 = undef,
  $notification_server_sendgrid_remote_engine_created        = undef,
  $notification_server_sendgrid_remote_engine_deleted        = undef,
  $notification_server_sendgrid_custom_workspace_created     = undef,
  $notification_server_sendgrid_custom_workspace_deleted     = undef,
  $notification_server_sendgrid_flow_execution_success       = undef,
  $notification_server_sendgrid_flow_execution_rejected_rows = undef,
  $notification_server_sendgrid_flow_execution_failed        = undef,
  $notification_server_sendgrid_template_plan_execution_success = undef,
  $notification_server_sendgrid_template_plan_execution_failed  = undef,

  $notification_subscription_db_host            = undef,
  $notification_subscription_db_port            = undef,
  $notification_subscription_db_password        = undef,
  $notification_subscription_db_max_connections = undef,

  $pe_service_username = undef,
  $pe_service_password = undef,

  $ams_postgres_server     = undef,
  $ams_postgres_password   = undef,

  $pe_db_host     = undef,
  $pe_db_password = undef,

  $quartz_db_host     = undef,
  $quartz_db_port     = undef,
  $quartz_db_user     = undef,
  $quartz_db_password = undef,
  $quartz_db_name     = undef,

  $trial_db_host     = undef,
  $trial_db_password = undef,

  $marketo_url                  = undef,
  $marketo_client_id            = undef,
  $marketo_client_secret        = undef,
  $marketo_list_id_tic_approved = undef,
  $marketo_list_id_tic_rejected = undef,
  $marketo_list_id_tic_pending  = undef,

  $confirm_email_sender        = undef,
  $confirm_email_repl_to       = undef,
  $confirm_email_body_template = undef,
  $confirm_email_external_url  = undef,
  $tipaas_email_subject        = undef,

  $webhooks_external_url  = undef,
  $webhooks_redis_host    = undef,
  $webhooks_redis_port    = undef,

  $rt_flow_ami_id               = undef,
  $rt_flow_security_groups      = undef,
  $rt_flow_instance_type        = undef,
  $rt_flow_subnet_id            = undef,
  $rt_flow_instance_profile     = undef,
  $rt_flow_failover_subnets_ids = undef,

  $rt_flow_t_dc          = undef,
  $rt_flow_t_environment = undef,
  $rt_flow_t_release     = undef,
  $rt_flow_t_branch      = undef,
  $rt_flow_t_profile     = undef,
  $rt_flow_t_subenv      = undef,

  $logs_transfer_presignedurl_timetolive = undef,
  $logs_datasource_servername            = undef,
  $logs_datasource_password              = undef,

  $logs_transfer_client_admin_url  = undef,
  $logs_transfer_client_username   = undef,
  $logs_transfer_client_password   = undef,
  $logs_transfer_client_upload_url = undef,

  $zookeeper_prefix = undef,

) {

  contain ::tic::services::params

  class { '::tic::common':
    java_home => $tic::services::params::java_home
  }

  contain ::tic::services::install

  # in case we are in build subenv we don't instantiate the config and service classes
  if $::t_subenv != 'build' {
    contain ::tic::services::config
    contain ::tic::services::service
  }

  Class['::tic::services::params'] ~>
  Class['::tic::common'] ~>
  Class['::tic::services::install'] ~>
  Class['::tic::services::config'] ~>
  Class['::tic::services::service']

}
