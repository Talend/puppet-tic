class tic::services::params {

  $java_home = pick($tic::services::java_home, undef)
  $java_xmx  = pick($tic::services::java_xmx,  '1024')

  $manage_packages         = pick($tic::services::manage_packages, true)
  $wrapper_diable_restarts = pick($tic::services::wrapper_diable_restarts, true)
  $version                 = pick($tic::services::version, 'latest')
  $karaf_base_path         = pick($tic::services::karaf_base_path, '/opt/talend/ipaas/rt-infra')

  $karaf_service_ensure   = pick($tic::services::karaf_service_ensure, 'running')
  $karaf_service_enable   = pick($tic::services::karaf_service_enable, true)
  $osgi_http_service_port = pick($tic::services::osgi_http_service_port, 8181)

  $karaf_features_install = pick($tic::services::karaf_features_install, [])

  $logging_level    = pick($tic::services::logging_level,    'INFO')
  $log_amq_messages = pick($tic::services::log_amq_messages, false)

  $account_manager_nodes    = pick($tic::services::account_manager_nodes,    'localhost')
  $activemq_nodes           = pick($tic::services::activemq_nodes,           'localhost')
  $ams_syncope_host         = pick($tic::services::ams_syncope_host,         'localhost')
  $artifact_manager_nodes   = pick($tic::services::artifact_manager_nodes,   'localhost')
  $bookkeeper_service_nodes = pick($tic::services::bookkeeper_service_nodes, 'localhost')
  $cms_node                 = pick($tic::services::cms_node,                 'localhost')
  $config_service_node      = pick($tic::services::config_service_node,      'localhost')
  $dts_service_node         = pick($tic::services::dts_service_node,         'localhost')
  $lts_service_node         = pick($tic::services::lts_service_node,         'localhost')
  $flow_manager_nodes       = pick($tic::services::flow_manager_nodes,       'localhost')
  $nexus_nodes              = pick($tic::services::nexus_nodes,              'localhost')
  $pe_service_nodes         = pick($tic::services::pe_service_nodes,         'localhost')
  $postgres_nodes           = pick($tic::services::postgres_nodes,           'localhost')
  $zookeeper_nodes          = pick($tic::services::zookeeper_nodes,          'localhost')
  $mongo_nodes              = pick($tic::services::mongo_nodes,              'localhost')
  $iam_service_node         = pick($tic::services::iam_service_node,         'localhost')
  $scim_service_node        = pick($tic::services::scim_service_node,        'localhost')
  $crypto_service_node      = pick($tic::services::crypto_service_node,      'localhost')
  $license_service_node     = pick($tic::services::license_service_node,     'localhost')


  $postgres_db_host    = pick($postgres_nodes,  'localhost')

  $ams_syncope_password = pick($tic::services::ams_syncope_password, 'missing')

  $activemq_broker_username = pick($tic::services::activemq_broker_username, 'tadmin')
  $activemq_broker_password = pick($tic::services::activemq_broker_password, 'missing')
  $activemq_nodes_list      = split($activemq_nodes, ',')
  $activemq_nodes_count     = size($activemq_nodes_list)
  $min_activemq_brokers     = pick($tic::services::min_activemq_brokers, 1)

  $elasticsearch_host = pick($tic::services::elasticsearch_host, 'localhost')
  $elasticsearch_port = pick($tic::services::elasticsearch_port, '8080')

  $activemq_broker_url    = pick($tic::services::activemq_broker_url, inline_template("<%= 'failover:(tcp://' + @activemq_nodes_list.sort().inject { |url,n| url + ':61616?keepAlive=true,' + 'tcp://' + n } + ':61616?keepAlive=true)?jms.prefetchPolicy.queuePrefetch=5'%>"))
  $ams_syncope_url        = pick($tic::services::ams_syncope_url, inline_template('http://<%= @ams_syncope_host %>:8080/syncope/rest'))
  $ams_url                = pick($tic::services::ams_url, inline_template('http://<%= @account_manager_nodes.split(",")[0] %>:8181/services/account-management-service'))
  $artifact_manager_url   = pick($tic::services::artifact_manager_url, inline_template('http://<%= @artifact_manager_nodes.split(",")[0] %>:8181/services/artifact-manager-service'))
  $bookkeeper_service_url = pick($tic::services::bookkeeper_service_url, inline_template('http://<%= @bookkeeper_service_nodes.split(",")[0] %>:8181/services/bookkeeper-service'))
  $cms_amq_broker_url     = pick($tic::services::cms_amq_broker_url, 'unconfigured')
  $cms_amq_broker_url_log = pick($tic::services::cms_amq_broker_url_log, 'unconfigured')
  $cms_dts_service_url    = pick($tic::services::cms_dts_service_url, 'unconfigured')
  $cms_lts_service_url    = pick($tic::services::cms_lts_service_url, 'unconfigured')
  $cms_nexus_url          = pick($tic::services::cms_nexus_url, 'unconfigured')
  $cms_url                = pick($tic::services::cms_url, "http://${cms_node}:8181/services/container-management-service")
  $dts_service_url        = pick($tic::services::dts_service_url, inline_template('http://<%= @dts_service_node %>:8181/services/data-transfer-service'))
  $lts_service_url        = pick($tic::services::lts_service_url, inline_template('http://<%= @lts_service_node %>:8181/services/logs-transfer-service-runtime'))
  $flow_manager_url       = pick($tic::services::flow_manager_url, inline_template('http://<%= @flow_manager_nodes.split(",")[0] %>:8181/services/flow-manager-service'))
  $nexus_urls             = pick($tic::services::nexus_urls, inline_template('<%= @nexus_nodes.split(",").map { |a| "http://#{a}/nexus" }.join(",") %>'))
  $pe_service_url         = pick($tic::services::pe_service_url, inline_template('http://<%= @pe_service_nodes.split(",")[0] %>:8181/services/plan-executor-service'))

  $nexus_password       = pick($tic::services::nexus_password,       'missing')
  $nexus_min_host_count = pick($tic::services::nexus_min_host_count, 1)

  $mongo_nodes_list      = split($mongo_nodes, ',')
  $mongo_admin_user      = pick($tic::services::mongo_admin_user,     'admin')
  $mongo_admin_password  = pick($tic::services::mongo_admin_password, 'missing')
  $mongo_db_name         = pick($tic::services::mongo_db_name,        'ipaas')
  $mongo_uri_base        = inline_template("<%= 'mongodb://' + @mongo_admin_user + ':' + @mongo_admin_password + '@' + @mongo_nodes_list.sort().join(',') + ':27017/' + @mongo_db_name %>")
  if size($mongo_nodes_list) > 1 {
    $mongo_uri = "${mongo_uri_base}?replicaSet=tipaas"
    $ams_mongo_replica_set_option = present
  } else {
    $mongo_uri = $mongo_uri_base
    $ams_mongo_replica_set_option = absent
  }

  $zookeeper_nodes_list  = split($zookeeper_nodes, ',')
  $zookeeper_nodes_count = size($zookeeper_nodes_list)
  $zookeeper_connection  = inline_template("<%= @zookeeper_nodes_list.sort().join(':2181,') + ':2181' %>")
  $min_zookeeper_nodes   = pick($tic::services::min_zookeeper_nodes, 1)

  $config_db_host     = pick($tic::services::config_db_host,     $postgres_db_host, 'localhost')
  $config_db_password = pick($tic::services::config_db_password, 'missing')

  $cms_db_host     = pick($tic::services::cms_db_host,     $postgres_db_host, 'localhost')
  $cms_db_password = pick($tic::services::cms_db_password, 'missing')

  $kms_key_alias            = pick($tic::services::kms_key_alias,            'ipaas_master_key')
  $crypto_current_region    = pick($tic::services::crypto_current_region,    'us-east-1')
  $crypto_secondary_regions = pick($tic::services::crypto_secondary_regions, 'us-west-2,eu-west-1')
  $crypto_db_host           = pick($tic::services::crypto_db_host,           $postgres_db_host)
  $crypto_db_password       = pick($tic::services::crypto_db_password,       'missing')

  $cr_bucket_name                      = pick($tic::services::cr_bucket_name,                      'undef')
  $cr_object_key_prefix                = pick($tic::services::cr_object_key_prefix,                'undef')
  $cr_presignedurl_upload_timetolive   = pick($tic::services::cr_presignedurl_upload_timetolive,   '1800')
  $cr_presignedurl_download_timetolive = pick($tic::services::cr_presignedurl_download_timetolive, '1800')
  $cr_size_limit_per_resource          = pick($tic::services::cr_size_limit_per_resource,          104857600)
  $cr_size_limit_per_account           = pick($tic::services::cr_size_limit_per_account,           1073741824)

  $dts_s3_bucket_rejected_data  = pick($tic::services::dts_s3_bucket_rejected_data,  'us-east-1-rd-tipaas-dts-rejected-talend-com')
  $dts_s3_bucket_logs_data      = pick($tic::services::dts_s3_bucket_logs_data,      'us-east-1-rd-tipaas-dts-logs-talend-com')
  $dts_s3_bucket_downloads_data = pick($tic::services::dts_s3_bucket_downloads_data, 'us-east-1-rd-tipaas-dts-downloads-talend-com')
  $dts_max_data_size            = pick($tic::services::dts_max_data_size,            5242880)
  $dts_shared_secret            = pick($tic::services::dts_shared_secret,            'missing')
  $dts_s3_prefix                = pick($tic::services::dts_s3_prefix,                'default')

  $time_to_unknown = pick($tic::services::time_to_unknown, 172800)

  $rt_aws_region                 = pick($tic::services::rt_aws_region,                 'local')
  $flow_undeploy_after_completed = pick($tic::services::flow_undeploy_after_completed, true)

  $notification_manager_input_queue       = pick($tic::services::notification_manager_input_queue,       'missing')
  $notification_client_failures_log       = pick($tic::services::notification_client_failures_log,       'missing')
  $notification_manager_destination_queue = pick($tic::services::notification_manager_destination_queue, 'missing')

  $notification_server_sendgrid_api_key                      = pick($tic::services::notification_server_sendgrid_api_key,                      'missing')
  $notification_server_sendgrid_user_created                 = pick($tic::services::notification_server_sendgrid_user_created,                 'missing')
  $notification_server_sendgrid_user_deleted                 = pick($tic::services::notification_server_sendgrid_user_deleted,                 'missing')
  $notification_server_sendgrid_remote_engine_created        = pick($tic::services::notification_server_sendgrid_remote_engine_created,        'missing')
  $notification_server_sendgrid_remote_engine_deleted        = pick($tic::services::notification_server_sendgrid_remote_engine_deleted,        'missing')
  $notification_server_sendgrid_custom_workspace_created     = pick($tic::services::notification_server_sendgrid_custom_workspace_created,     'missing')
  $notification_server_sendgrid_custom_workspace_deleted     = pick($tic::services::notification_server_sendgrid_custom_workspace_deleted,     'missing')
  $notification_server_sendgrid_flow_execution_success       = pick($tic::services::notification_server_sendgrid_flow_execution_success,       'missing')
  $notification_server_sendgrid_flow_execution_rejected_rows = pick($tic::services::notification_server_sendgrid_flow_execution_rejected_rows, 'missing')
  $notification_server_sendgrid_flow_execution_failed        = pick($tic::services::notification_server_sendgrid_flow_execution_failed,        'missing')
  $notification_server_sendgrid_template_plan_execution_success = pick($tic::services::notification_server_sendgrid_template_plan_execution_success, 'peSuccess')
  $notification_server_sendgrid_template_plan_execution_failed  = pick($tic::services::notification_server_sendgrid_template_plan_execution_failed,  'peFailed')
  $notification_server_mail_body_cloud_url                      = pick($tic::services::notification_server_mail_body_cloud_url, 'missing')

  $notification_subscription_db_host            = pick($tic::services::notification_subscription_db_host,            $postgres_db_host)
  $notification_subscription_db_port            = pick($tic::services::notification_subscription_db_port,            '5432')
  $notification_subscription_db_name            = pick($tic::services::notification_subscription_db_name,            'notification_subscription')
  $notification_subscription_db_username        = pick($tic::services::notification_subscription_db_username,        'notification_subscription')
  $notification_subscription_db_password        = pick($tic::services::notification_subscription_db_password,        'missing')
  $notification_subscription_db_max_connections = pick($tic::services::notification_subscription_db_max_connections, '10')

  $notification_subscription_memcached_host = pick($tic::services::notification_subscription_memcached_host, 'localhost')
  $notification_subscription_memcached_port = pick($tic::services::notification_subscription_memcached_port, '11211')
  $notification_subscription_memcached_url  = pick(
    $tic::services::notification_subscription_memcached_url,
    "${notification_subscription_memcached_host}:${notification_subscription_memcached_port}"
  )

  $pe_service_username = pick($tic::services::pe_service_username, 'tadmin')
  $pe_service_password = pick($tic::services::pe_service_password, 'missing')

  $ams_postgres_server     = pick($tic::services::ams_postgres_server,   $postgres_db_host)
  $ams_postgres_password   = pick($tic::services::ams_postgres_password, 'missing')

  $ams_mail_config_update_period   = pick($tic::services::ams_mail_config_update_period, '1800000')
  $ams_mail_config_password_reset  = pick($tic::services::ams_mail_config_password_reset, 'templates/password_reset_email_description.xml')
  $ams_mail_config_user_created    = pick($tic::services::ams_mail_config_user_created, 'templates/user_created_email_description.xml')
  $ams_password_reset_url_template = pick($tic::services::ams_password_reset_url_template, 'http://daily-web.tipaas.com/#/reset_password?token=')
  $ams_current_region              = pick($tic::services::ams_current_region, 'undef')
  $ams_disaster_region             = pick($tic::services::ams_disaster_region, 'undef')
  $amq_security_switch             = pick($tic::services::amq_security_switch, false)

  $pe_db_host     = pick($tic::services::pe_db_host, $postgres_db_host)
  $pe_db_password = pick($tic::services::pe_db_password, 'missing')

  $quartz_db_host     = pick($tic::services::quartz_db_host,     $postgres_db_host)
  $quartz_db_port     = pick($tic::services::quartz_db_port,     5432)
  $quartz_db_user     = pick($tic::services::quartz_db_user,     'scheduler')
  $quartz_db_password = pick($tic::services::quartz_db_password, 'missing')
  $quartz_db_name     = pick($tic::services::quartz_db_name,     'scheduler')

  $quartz_scheduler_instance_id           = pick($tic::services::quartz_scheduler_instance_id,           'AUTO')
  $quartz_jobstore_isclustered            = pick($tic::services::quartz_jobstore_isclustered,            true)
  $quartz_jobstore_cluster_check_interval = pick($tic::services::quartz_jobstore_cluster_check_interval, 20000)

  $trial_db_host     = pick($tic::services::trial_db_host,     $postgres_db_host)
  $trial_db_password = pick($tic::services::trial_db_password, 'missing')

  $marketo_url                  = pick($tic::services::marketo_url,                  'undef')
  $marketo_client_id            = pick($tic::services::marketo_client_id,            'undef')
  $marketo_client_secret        = pick($tic::services::marketo_client_secret,        'undef')
  $marketo_list_id_tic_approved = pick($tic::services::marketo_list_id_tic_approved, 'undef')
  $marketo_list_id_tic_rejected = pick($tic::services::marketo_list_id_tic_rejected, 'undef')
  $marketo_list_id_tic_pending  = pick($tic::services::marketo_list_id_tic_pending,  'undef')

  $confirm_email_sender        = pick($tic::services::confirm_email_sender,        'Talend - Support <support@talend.com>')
  $confirm_email_repl_to       = pick($tic::services::confirm_email_repl_to,       'Talend - Support <support@talend.com>')
  $confirm_email_body_template = pick($tic::services::confirm_email_body_template, 'templates/confirmation_email_template.html')
  $confirm_email_external_url  = pick($tic::services::confirm_email_external_url,  'https://integrationcloud.talend.com/#/signup/login?trialKey=')
  $tipaas_email_subject        = pick($tic::services::tipaas_email_subject,        'Talend Integration Cloud Evaluation: Confirmation')

  $webhooks_url           = pick($tic::services::webhooks_url,           'unconfigured')
  $webhooks_external_url  = pick($tic::services::webhooks_external_url,  'unconfigured')
  $webhooks_redis_host    = pick($tic::services::webhooks_redis_host,    'unconfigured')
  $webhooks_redis_port    = pick($tic::services::webhooks_redis_port,    6379)

  $redis_cache_host   = pick($tic::services::redis_cache_host, 'unconfigured')
  $redis_cache_port   = pick($tic::services::redis_cache_port, 6379)
  $redis_cache_db_tmc = pick($tic::services::redis_cache_db_tmc, 9)


  $rt_flow_ami_id                = pick_default($tic::services::rt_flow_ami_id,               '')
  $rt_flow_security_groups       = pick_default($tic::services::rt_flow_security_groups,      '')
  $rt_flow_instance_type         = pick_default($tic::services::rt_flow_instance_type,        '')
  $rt_flow_subnet_id             = pick_default($tic::services::rt_flow_subnet_id,            '')
  $rt_flow_instance_profile      = pick_default($tic::services::rt_flow_instance_profile,     '')
  $rt_flow_failover_subnets_ids  = pick_default($tic::services::rt_flow_failover_subnets_ids, '')

  $rt_flow_t_dc          = pick_default($tic::services::rt_flow_t_dc,          '')
  $rt_flow_t_environment = pick_default($tic::services::rt_flow_t_environment, 'dv')
  $rt_flow_t_release     = pick_default($tic::services::rt_flow_t_release,     '')
  $rt_flow_t_branch      = pick_default($tic::services::rt_flow_t_branch,      '')
  $rt_flow_t_profile     = pick_default($tic::services::rt_flow_t_profile,     '')
  $rt_flow_t_subenv      = pick_default($tic::services::rt_flow_t_subenv,      '')

  $logs_transfer_presignedurl_timetolive = pick($tic::services::logs_transfer_presignedurl_timetolive, 86400)
  $logs_datasource_servername            = pick($tic::services::logs_datasource_servername,            'undef')
  $logs_datasource_password              = pick($tic::services::logs_datasource_password,              'undef')

  $logs_transfer_client_admin_url  = pick($tic::services::logs_transfer_client_admin_url,  'missing')
  $logs_transfer_client_username   = pick($tic::services::logs_transfer_client_username,   'missing')
  $logs_transfer_client_password   = pick($tic::services::logs_transfer_client_password,   'missing')
  $logs_transfer_client_upload_url = pick($tic::services::logs_transfer_client_upload_url, 'missing')

  $dispatcher_nexus_url                  = pick($tic::services::dispatcher_nexus_url, 'unconfigured')

  $zookeeper_prefix = pick($tic::services::zookeeper_prefix, '/subenv/talend/role/bookkeeper')

  $dispatcher_input_queue    = pick($tic::services::dispatcher_input_queue,    'ipaas.talend.dispatcher.input.queue')
  $dispatcher_response_queue = pick($tic::services::dispatcher_response_queue, 'ipaas.talend.dispatcher.response.queue')
  $dispatcher_redis_host     = pick($tic::services::dispatcher_redis_host,     'unconfigured')
  $dispatcher_redis_port     = pick($tic::services::dispatcher_redis_port,     6379)

  $iam_service_url        = pick($tic::services::iam_service_url, "http://${iam_service_node}")
  $scim_service_url       = pick($tic::services::scim_service_url, "http://${scim_service_node}")
  $crypto_service_url     = pick($tic::services::crypto_service_url, "http://${crypto_service_node}")
  $config_service_url     = pick($tic::services::config_service_url, "http://${config_service_node}")
  $license_service_url    = pick($tic::services::license_service_url, "http://${license_service_node}")

  $zipkin_enabled       = pick($tic::services::zipkin_enabled,       false)
  $zipkin_kafka_topic   = pick($tic::services::zipkin_kafka_topic,   'unconfigured')
  $zipkin_kafka_servers = pick($tic::services::zipkin_kafka_servers, 'unconfigured')
  $zipkin_sampling_rate = pick($tic::services::zipkin_sampling_rate, '0.1')

  $eventsource_kafka_servers = pick($tic::services::eventsource_kafka_servers, 'unconfigured')
  $eventsource_kafka_topic   = pick($tic::services::eventsource_kafka_topic,   'unconfigured')
  $eventsource_kafka_log     = pick($tic::services::eventsource_kafka_log,     false)

  $kafka_apps_servers  = pick($tic::services::eventsource_kafka_servers, 'localhost:9092')
  $kafka_apps_topic    = pick($tic::services::kafka_apps_topic,   'app-to-runtime')

  $kafka_statuses_hosts  = pick($tic::services::eventsource_kafka_customers_logs, 'localhost:9092')
  $kafka_statuses_topic  = pick($tic::services::kafka_statuses_topic,   'events-to-platform')

  $vault_url = pick($tic::services::vault_url, 'http://localhost:8200')
  $vault_ipaas_role_id = pick($tic::services::vault_ipaas_role_id, 'unconfigured')
  $vault_ipaas_secret_id = pick($tic::services::vault_ipaas_secret_id, 'unconfigured')
}
