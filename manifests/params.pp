#manage params logic, validation, defaults and other
#FIXME: break this file by role
class tic::params inherits tic::globals {

  $account_id                    = pick($userdata_account_id, $hiera_account_id, $default_account_id)
  $ams_url                       = $hiera_ams_url
  $artifact_manager_password     = pick($userdata_artifact_manager_password, $default_artifact_manager_password)
  $artifact_manager_url          = pick($userdata_artifact_manager_url, $default_artifact_manager_url)
  $artifact_manager_username     = pick($userdata_artifact_manager_username, $default_artifact_manager_username)
  $container_id                  = pick($userdata_container_id, $hiera_container_id, $default_container_id)
  $crypto_service_url            = pick($userdata_crypto_service_url, $default_crypto_service_url)
  $custom_resources_url          = pick($userdata_custom_resources_url, $hiera_custom_resources_url, $default_custom_resources_url)
  $dispatcher_input_queue        = pick($userdata_dispatcher_input_queue, $hiera_dispatcher_input_queue, $default_dispatcher_input_queue)
  $dispatcher_response_queue     = pick($userdata_dispatcher_response_queue, $hiera_dispatcher_response_queue, $default_dispatcher_response_queue)
  $dts_service_url               = pick($userdata_dts_service_url, $hiera_dts_service_url, $default_dts_service_url)
  $flow_manager_password         = pick($userdata_flow_manager_password, $default_flow_manager_password)
  $flow_manager_url              = pick($userdata_flow_manager_url, $hiera_flow_manager_url, $default_flow_manager_url)
  $flow_manager_username         = pick($userdata_flow_manager_username, $default_flow_manager_username)
  $flow_undeploy_after_completed = pick($userdata_flow_undeploy_after_completed, $hiera_flow_undeploy_after_completed, $default_flow_undeploy_after_completed)
  $karaf_features_install        = pick($userdata_karaf_features_install, $hiera_karaf_features_install, $default_karaf_features_install)
  $karaf_boot_features_real      = join($karaf_features_install,',')
  $log_amq_messages              = $hiera_log_amq_messages
  $logging_level                 = $hiera_logging_level
  $marketo_client_id               = pick($userdata_marketo_client_id, $hiera_marketo_client_id, $default_marketo_client_id)
  $marketo_client_secret           = pick($userdata_marketo_client_secret, $hiera_marketo_client_secret, $default_marketo_client_secret)
  $marketo_list_id_tic_approved    = pick($userdata_marketo_list_id_tic_approved, $hiera_marketo_list_id_tic_approved, $default_marketo_list_id_tic_approved)
  $marketo_list_id_tic_pending     = pick($userdata_marketo_list_id_tic_pending, $hiera_marketo_list_id_tic_pending, $default_marketo_list_id_tic_pending)
  $marketo_list_id_tic_rejected    = pick($userdata_marketo_list_tic_rejected, $hiera_marketo_list_id_tic_rejected, $default_marketo_list_id_tic_rejected)
  $marketo_url                     = pick($userdata_marketo_url, $hiera_marketo_url, $default_marketo_url)
  $mongo_node                    = pick($userdata_mongo_node, $hiera_mongo_node, $default_mongo_node)
  $mongo_uri                     = $hiera_mongo_uri
  $nexus_user                    = pick($userdata_nexus_user, $hiera_nexus_user, $default_nexus_user)
  $pe_service_url                = pick($userdata_pe_service_url, $hiera_pe_service_url, $default_pe_service_url)
  $queue_input_consumers_count   = pick($userdata_queue_input_consumers_count, $hiera_queue_input_consumers_count, $default_queue_input_consumers_count)
  $queue_input_name              = pick($userdata_queue_input_name, $hiera_queue_input_name, $default_queue_input_name)
  $rt_aws_region                 = pick($userdata_rt_aws_region, $hiera_rt_aws_region, $default_rt_aws_region)
  $status_update_interval        = pick($userdata_status_update_interval, $hiera_status_update_interval, $default_status_update_interval)
  $trial_service_url             = pick($userdata_trial_service_url, $hiera_trial_service_url, $default_trial_service_url)
  $version                       = pick($userdata_version,$::t_appversion, $hiera_version, $default_version)
  $workspace_url                 = pick($userdata_workspace_url, $hiera_workspace_url, $default_workspace_url)


  #FIXME: move all params from above to the role specific case
  case $role {
    'engine' : {
      $karaf_service_ensure        = pick($userdata_karaf_service_ensure, $hiera_karaf_service_ensure, $default_karaf_service_ensure)
      $queue_response_name         = $userdata_queue_response_name
      $activemq_broker_url         = $userdata_activemq_broker_url
      $activemq_broker_username    = $userdata_activemq_broker_username
      #FIXME - real decrypt
      $activemq_broker_password    = $userdata_activemq_broker_password_secret
      #move to multiple nexus urls
      $nexus_urls                  = pick($userdata_nexus_url, $hiera_nexus_url, $default_nexus_url)
      $nexus_url = $nexus_urls
      $heartbeat_interval          = pick($userdata_heartbeat_interval, $hiera_heartbeat_interval, $default_heartbeat_interval)
    }
    'services': {

      #move to multiple nexus urls
      $nexus_urls                  = pick($userdata_nexus_url, $hiera_nexus_url, $default_nexus_url)
      $nexus_url = $nexus_urls
      $activemq_broker_url         = pick($userdata_activemq_broker_url, $hiera_activemq_broker_url, $default_activemq_broker_url)
      $karaf_service_ensure        = pick($real_karaf_service_ensure, $userdata_karaf_service_ensure, $hiera_karaf_service_ensure, $default_karaf_service_ensure)
      $rt_flow_instance_type       = $hiera_rt_flow_instance_type
      $dts_s3_bucket_test_data     = pick($userdata_dts_s3_bucket_test_data, $hiera_dts_s3_bucket_test_data)
      $dts_s3_bucket_rejected_data = pick($userdata_dts_s3_bucket_rejected_data, $hiera_dts_s3_bucket_rejected_data)
      $dts_s3_bucket_logs_data     = $hiera_dts_s3_bucket_logs_data
      $dts_s3_bucket_downloads_data = $hiera_dts_s3_bucket_downloads_data
      $dts_s3_url_ttl              = pick($userdata_dts_s3_url_ttl, $hiera_dts_s3_url_ttl)
      $dts_max_data_size           = pick($userdata_dts_max_data_size, $hiera_dts_max_data_size)
      $dts_shared_secret           = $hiera_dts_shared_secret

      $quartz_db_name     = $hiera_quartz_db_name
      $quartz_db_port     = $hiera_quartz_db_port
      $quartz_db_user     = $hiera_quartz_db_user
      $quartz_db_password = $hiera_quartz_db_password
      $quartz_db_host     = $hiera_postgres_db_host

      $elasticsearch_host = $hiera_elasticsearch_host
      $elasticsearch_port = $hiera_elasticsearch_port

      #TODO: check if we need to implement those in hiera as well
      $rt_flow_instance_profile = $userdata_rt_flow_instance_profile

      $rt_flow_ami_id          = pick($userdata_rt_flow_ami_id, $hiera_rt_flow_ami_id, $default_rt_flow_ami_id)
      $rt_flow_security_groups = pick($userdata_rt_flow_security_groups, $hiera_rt_flow_security_groups, $default_rt_flow_security_groups)
      $rt_flow_subnet          = pick($userdata_rt_flow_subnet, $hiera_rt_flow_subnet, $default_rt_flow_subnet)

      $ams_postgres_server             = $hiera_postgres_db_host
      $ams_postgres_password           = $hiera_ams_postgres_password
      $ams_syncope_url                 = $hiera_ams_syncope_url
      $ams_syncope_password            = $hiera_ams_syncope_password
      $ams_mail_config_update_period   = $hiera_ams_mail_config_update_period
      $ams_mail_config_password_reset  = $hiera_ams_mail_config_password_reset
      $ams_mail_config_user_created    = $hiera_ams_mail_config_user_created
      $ams_password_reset_url_template = $hiera_ams_password_reset_url_template
      $ams_current_region              = $hiera_ams_current_region
      $ams_disaster_region             = $hiera_ams_disaster_region

      $zookeeper_connection  = $hiera_zookeeper_connection

      $bookkeeper_service_url = $hiera_bookkeeper_service_url
      $crypto_db_host = $hiera_postgres_db_host
      $cms_db_host = $hiera_postgres_db_host
      $config_db_host = $hiera_postgres_db_host
      $trial_db_host = $hiera_postgres_db_host
      $pe_db_host = $hiera_postgres_db_host

      $cms_dts_service_url = pick($userdata_cms_dts_service_url, $hiera_cms_dts_service_url, 'unconfigured')
      $cms_amq_broker_url  = pick($userdata_cms_amq_broker_url, $hiera_cms_amq_broker_url, 'unconfigured')
      $cms_nexus_url       = pick($userdata_cms_nexus_url, $hiera_cms_nexus_url, 'unconfigured')

      $cr_bucket_name                        = pick($userdata_cr_bucket_name, $hiera_cr_bucket_name, $default_cr_bucket_name)
      $cr_object_key_prefix                  = pick($userdata_cr_object_key_prefix, $hiera_cr_object_key_prefix, $default_cr_object_key_prefix)
      $cr_presignedurl_upload_timetolive     = pick($userdata_cr_presignedurl_upload_timetolive, $hiera_cr_presignedurl_upload_timetolive, $default_cr_presignedurl_upload_timetolive)
      $cr_presignedurl_download_timetolive   = pick($userdata_cr_presignedurl_download_timetolive, $hiera_cr_presignedurl_download_timetolive, $default_cr_presignedurl_download_timetolive)
      $cr_size_limit_per_resource            = pick($userdata_cr_size_limit_per_resource, $hiera_cr_size_limit_per_resource, $default_cr_size_limit_per_resource)
      $cr_size_limit_per_account             = pick($userdata_cr_size_limit_per_account, $hiera_cr_size_limit_per_account, $default_cr_size_limit_per_account)
      $webhooks_external_url = $hiera_webhooks_external_url
      $webhooks_redis_host = pick($userdata_webhooks_redis_host, $hiera_webhooks_redis_host)
      $webhooks_redis_port     = $hiera_webhooks_redis_port

      $notification_subscription_db_host             = $hiera_postgres_db_host
      $notification_subscription_db_port             = pick($userdata_notification_subscription_db_port, $hiera_notification_subscription_db_port)
      $notification_subscription_db_password         = pick($userdata_notification_subscription_db_password, $hiera_notification_subscription_db_password)
      $notification_subscription_db_max_connections  = pick($userdata_notification_subscription_db_max_connections, $hiera_notification_subscription_db_max_connections)

      $notification_manager_input_queue             = pick($userdata_notification_manager_input_queue, $hiera_notification_manager_input_queue)
      $notification_manager_destination_queue       = pick($userdata_notification_manager_destination_queue, $hiera_notification_manager_destination_queue)

      $notification_client_failures_log             = pick($userdata_notification_client_failures_log, $hiera_notification_client_failures_log)

      $notification_server_sendgrid_api_key                        = pick($userdata_notification_server_sendgrid_api_key, $hiera_notification_server_sendgrid_api_key)
      $notification_server_sendgrid_user_created                   = pick($userdata_notification_server_sendgrid_user_created, $hiera_notification_server_sendgrid_user_created)
      $notification_server_sendgrid_user_deleted                   = pick($userdata_notification_server_sendgrid_user_deleted, $hiera_notification_server_sendgrid_user_deleted)
      $notification_server_sendgrid_remote_engine_created          = pick($userdata_notification_server_sendgrid_remote_engine_created, $hiera_notification_server_sendgrid_remote_engine_created)
      $notification_server_sendgrid_remote_engine_deleted          = pick($userdata_notification_server_sendgrid_remote_engine_deleted, $hiera_notification_server_sendgrid_remote_engine_deleted)
      $notification_server_sendgrid_custom_workspace_created       = pick($userdata_notification_server_sendgrid_custom_workspace_created, $hiera_notification_server_sendgrid_custom_workspace_created)
      $notification_server_sendgrid_custom_workspace_deleted       = pick($userdata_notification_server_sendgrid_custom_workspace_deleted, $hiera_notification_server_sendgrid_custom_workspace_deleted)
      $notification_server_sendgrid_flow_execution_success         = pick($userdata_notification_server_sendgrid_flow_execution_success, $hiera_notification_server_sendgrid_flow_execution_success)
      $notification_server_sendgrid_flow_execution_rejected_rows   = pick($userdata_notification_server_sendgrid_flow_execution_rejected_rows, $hiera_notification_server_sendgrid_flow_execution_rejected_rows)
      $notification_server_sendgrid_flow_execution_failed          = pick($userdata_notification_server_sendgrid_flow_execution_failed, $hiera_notification_server_sendgrid_flow_execution_failed)

    }
    'frontend': {
      $sts_host             = $hiera_ams_syncope_host
      $karaf_service_ensure = pick($userdata_karaf_service_ensure, $hiera_karaf_service_ensure, $default_karaf_service_ensure)
      $ams_syncope_url       = $hiera_ams_syncope_url
      $ams_syncope_password  = $hiera_ams_syncope_password
      $data_prep_service_url = pick($userdata_data_prep_service_url, $hiera_data_prep_service_url, $default_data_prep_service_url)
      $elasticache_address   = pick($userdata_elasticache_address, $hiera_elasticache_address, 'unconfigured')
      $schema_discovery_service_url = pick($hiera_schema_discovery_service_url, 'unconfigured')
      $webhooks_service_url = $hiera_webhooks_service_url
      $s3_download_contentfile_name = $hiera_s3_download_contentfile_name

    }
    'base': {
    }
    default: {
    }
  }
}

