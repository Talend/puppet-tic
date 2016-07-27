# This class has the configuration lookup logic.
# It initializes 3 variables for each property:
# default_property, hiera_property, userdata_property
# the one property to use is picked in the tic::params class
# the heararchy is as follows: tic::globals -> tic::params -> tic -> [tic::engine|tic::services|tic::frontend]

class tic::globals(

  $activemq_broker_url                                             = undef,
  $activemq_broker_username                                        = undef,
  $activemq_broker_password                                        = undef,
  $cms_db_password                                                 = undef,
  $cms_node                                                        = undef,
  $config_db_password                                              = undef,
  $config_service_node                                             = undef,
  $confirm_email_body_template                                     = undef,
  $confirm_email_external_url                                      = undef,
  $confirm_email_repl_to                                           = undef,
  $confirm_email_sender                                            = undef,
  $crypto_db_password                                              = 'missing',
  $crypto_secondary_regions                                        = 'us-west-2,eu-west-1',
  $data_prep_service_url                                           = undef,
  $default_activemq_nodes                                          = 'localhost',
  $default_artifact_manager_nodes                                  = 'localhost',
  $default_crypto_service_nodes                                    = 'localhost',
  $default_custom_resources_nodes                                  = 'localhost',
  $default_data_prep_service_nodes                                 = 'localhost',
  $default_flow_manager_nodes                                      = 'localhost',
  $default_nexus_nodes                                             = 'localhost',
  $default_pe_service_nodes                                        = 'localhost',
  $default_trial_service_nodes                                     = 'localhost',
  $default_webhooks_service_nodes                                  = 'localhost',
  $dts_s3_prefix                                                   = 'default',
  $hiera_account_manager_nodes                                     = 'localhost',
  $hiera_activemq_broker_url                                       = undef,
  $hiera_ams_current_region                                        = 'missing',
  $hiera_ams_disaster_region                                       = 'missing',
  $hiera_ams_mail_config_password_reset                            = 'missing',
  $hiera_ams_mail_config_update_period                             = 'missing',
  $hiera_ams_mail_config_user_created                              = 'missing',
  $hiera_ams_password_reset_url_template                           = 'missing',
  $hiera_ams_postgres_password                                     = 'missing',
  $hiera_ams_syncope_host                                          = 'missing',
  $hiera_ams_syncope_password                                      = 'missing',
  $hiera_bookkeeper_service_nodes                                  = 'localhost',
  $hiera_cms_amq_broker_url                                        = 'unconfigured',
  $hiera_cms_dts_service_url                                       = 'unconfigured',
  $hiera_cms_nexus_url                                             = 'unconfigured',
  $hiera_cr_bucket_name                                            = undef,
  $hiera_cr_object_key_prefix                                      = undef,
  $hiera_cr_presignedurl_download_timetolive                       = undef,
  $hiera_cr_presignedurl_upload_timetolive                         = undef,
  $hiera_cr_size_limit_per_account                                 = undef,
  $hiera_cr_size_limit_per_resource                                = undef,
  $hiera_data_prep_service_url                                     = undef,
  $hiera_dts_max_data_size                                         = 5242880,
  $hiera_dts_s3_bucket_downloads_data                              = undef,
  $hiera_dts_s3_bucket_logs_data                                   = undef,
  $hiera_dts_s3_bucket_rejected_data                               = undef,
  $hiera_dts_s3_bucket_test_data                                   = undef,
  $hiera_dts_s3_url_ttl                                            = 1800,
  $hiera_dts_service_nodes                                         = [$::hostname],
  $hiera_dts_shared_secret                                         = undef,
  $hiera_elasticache_address                                       = undef,
  $hiera_elasticsearch_host                                        = 'localhost',
  $hiera_elasticsearch_port                                        = '8080',
  $hiera_heartbeat_interval                                        = '180',
  $hiera_karaf_additional_features_install                         = undef,
  $hiera_karaf_base_features_install                               = undef,
  $hiera_karaf_service_ensure                                      = undef,
  $hiera_log_amq_messages                                          = false,
  $hiera_logging_level                                             = 'INFO',
  $hiera_marketo_client_id                                         = undef,
  $hiera_marketo_client_secret                                     = undef,
  $hiera_marketo_list_id_tic_approved                              = undef,
  $hiera_marketo_list_id_tic_pending                               = undef,
  $hiera_marketo_list_id_tic_rejected                              = undef,
  $hiera_marketo_url                                               = undef,
  $hiera_mongo_admin_password                                      = 'admin',
  $hiera_mongo_admin_user                                          = 'admin',
  $hiera_mongo_db_name                                             = 'ipaas',
  $hiera_mongo_nodes                                               = ['localhost'],
  $hiera_nexus_nodes                                               = undef,
  $hiera_nexus_url                                                 = undef,
  $hiera_notification_client_failures_log                          = 'missing',
  $hiera_notification_manager_destination_queue                    = 'missing',
  $hiera_notification_manager_input_queue                          = 'missing',
  $hiera_notification_server_sendgrid_api_key                      = 'missing',
  $hiera_notification_server_sendgrid_custom_workspace_created     = 'missing',
  $hiera_notification_server_sendgrid_custom_workspace_deleted     = 'missing',
  $hiera_notification_server_sendgrid_flow_execution_failed        = 'missing',
  $hiera_notification_server_sendgrid_flow_execution_rejected_rows = 'missing',
  $hiera_notification_server_sendgrid_flow_execution_success       = 'missing',
  $hiera_notification_server_sendgrid_remote_engine_created        = 'missing',
  $hiera_notification_server_sendgrid_remote_engine_deleted        = 'missing',
  $hiera_notification_server_sendgrid_user_created                 = 'missing',
  $hiera_notification_server_sendgrid_user_deleted                 = 'missing',
  $hiera_notification_subscription_db_max_connections              = 'missing',
  $hiera_notification_subscription_db_password                     = 'missing',
  $hiera_notification_subscription_db_port                         = 'missing',
  $hiera_postgres_db_host                                          = 'localhost',
  $hiera_quartz_db_name                                            = 'scheduler',
  $hiera_quartz_db_password                                        = undef,
  $hiera_quartz_db_port                                            = 5432,
  $hiera_quartz_db_user                                            = 'scheduler',
  $hiera_rt_aws_region                                             = undef,
  $hiera_rt_flow_ami_id                                            = undef,
  $hiera_rt_flow_instance_type                                     = 't2.small',
  $hiera_rt_flow_security_groups                                   = undef,
  $hiera_rt_flow_subnet                                            = '',
  $hiera_s3_download_contentfile_name                              = undef,
  $hiera_schema_discovery_service_nodes                            = 'localhost',
  $hiera_version                                                   = 'installed',
  $hiera_webhooks_external_url                                     = 'unconfigured',
  $hiera_webhooks_redis_host                                       = 'unconfigured',
  $hiera_webhooks_redis_port                                       = 6379,
  $hiera_zookeeper_nodes                                           = 'localhost',
  $java_home                                                       = undef,
  $java_xmx                                                        = undef,
  $karaf_features_install                                          = undef,
  $karaf_service_ensure                                            = undef,
  $kms_key_alias                                                   = undef,
  $manage_packages                                                 = true,
  $marketplace_url                                                 = 'https://exchange.talend.com',
  $min_activemq_brokers                                            = 1,
  $min_zookeeper_nodes                                             = 1,
  $nexus_min_host_count                                            = 1,
  $nexus_password                                                  = 'admin123',
  $nexus_url                                                       = undef,
  $notification_subscription_nodes                                 = 'localhost',
  $notifier_service_nodes                                          = 'localhost',
  $pe_db_password                                                  = 'missing',
  $pe_service_password                                             = 'missing',
  $pe_service_username                                             = 'tadmin',
  $role                                                            = undef,
  $rt_flow_lxc_enable                                              = true,
  $rt_flow_purge_puppet                                            = true,
  $subenv_prefix                                                   = undef,
  $tipaas_email_subject                                            = undef,
  $trial_db_password                                               = 'missing',
  $version                                                         = undef,
  $web_enable_test_context                                         = undef,
  $web_samples_account_name                                        = 'examples.talend.com',
  $web_samples_workspace_type                                      = 'Shared',
  $web_use_ssl                                                     = undef,
  $webhooks_db_password                                            = undef,
  $wrapper_diable_restarts                                         = true,

) {

  $url_re = '^(https?:\/\/)?([\da-z\.-]+):(\d+)?([\/\w \.-]*)*\/?$'

  #FIXME: remove most of those defaults and break the puppet run in case of missing value
  $default_karaf_features_install        = ['missing_karaf_features_install']
  $default_account_id                    = 'default_account_id'
  $default_container_id                  = 'default_container_id'
  $default_queue_input_name              = 'default_queue_input_name'
  $default_queue_input_consumers_count   = '5'
  $default_nexus_user                    = 'admin'
  $default_status_update_interval        = 'admin123'
  $default_dispatcher_input_queue        = 'ipaas.dispatcher.input.queue'
  $default_dispatcher_response_queue     = 'ipaas.dispatcher.response.queue'
  $default_flow_undeploy_after_completed = true
  $default_workspace_url                 = '/ipaas-server/services'
  $default_heartbeat_interval            = '180'
  $default_version                       = undef

  $default_flow_manager_url              = inline_template('http://<%=@default_flow_manager_nodes.split(",")[0]%>:8181/services/flow-manager-service')

  $default_flow_manager_username         = 'tadmin'
  $default_flow_manager_password         = 'tadmin'

  $default_artifact_manager_url          = inline_template('http://<%=@default_artifact_manager_nodes.split(",")[0]%>:8181/services/artifact-manager-service')

  $default_crypto_service_url          = inline_template('http://<%=@default_crypto_service_nodes.split(",")[0]%>:8181/services/crypto-service')


  $hiera_bookkeeper_service_url        = inline_template('http://<%=@hiera_bookkeeper_service_nodes.split(",")[0]%>:8181/services/bookkeeper-service')

  $hiera_schema_discovery_service_url   = inline_template('http://<%=@hiera_schema_discovery_service_nodes.split(",")[0]%>:8181/services/schema-discovery-service')

  $default_artifact_manager_username     = 'tadmin'
  $default_artifact_manager_password     = 'tadmin'

  $default_rt_flow_ami_id                = 'default_rt_flow_ami_id'
  $default_rt_flow_security_groups       = ['default_sg']
  $default_rt_flow_subnet                = 'FIXME'
  $default_rt_aws_region                 = 'local'

  $default_nexus_url = inline_template('<%=@default_nexus_nodes.split(",").map { |a| "http://"+a+":8081/nexus" }.join(",")%>')

  $default_data_prep_service_url = inline_template('<%=@default_data_prep_service_nodes.split(",").map { |a| "http://"+a+":8080/datasets" }.join(",")%>')

  $default_mongo_node = 'localhost'

  $default_dts_s3_url_ttl = 1800
  $default_dts_max_data_size = 5242880

  $default_quartz_db_name          = 'scheduler'
  $default_quartz_db_port          = 5432
  $default_quartz_db_user          = 'scheduler'

  $default_marketo_url                   = 'undef'
  $default_marketo_client_id             = 'undef'
  $default_marketo_client_secret         = 'undef'
  $default_marketo_list_id_tic_approved  = 'undef'
  $default_marketo_list_id_tic_rejected  = 'undef'
  $default_marketo_list_id_tic_pending   = 'undef'

  $default_cr_bucket_name                        = 'undef'
  $default_cr_object_key_prefix                  = 'undef'
  $default_cr_presignedurl_upload_timetolive     = 'undef'
  $default_cr_presignedurl_download_timetolive   = 'undef'
  $default_cr_size_limit_per_resource            = 'undef'
  $default_cr_size_limit_per_account             = 'undef'
  $default_custom_resources_url                  = 'unconfigured'

  $hiera_custom_resources_url                  = inline_template('http://<%=@default_custom_resources_nodes.split(",")[0]%>:8181/services/custom-resources')
  $hiera_webhooks_service_url            = inline_template('http://<%=@default_webhooks_service_nodes.split(",")[0]%>:8181/services/webhooks-service')
  $notifier_service_url                  = inline_template('http://<%=@notifier_service_nodes.split(",")[0]%>:8181/services/notifier-service')

  $notification_subscription_url         = inline_template('http://<%=@notification_subscription_nodes.split(",")[0]%>:8181/services/notification-subscription')


  if size($hiera_karaf_additional_features_install) > 0 {
    $hiera_karaf_features_install              = concat($hiera_karaf_base_features_install,$hiera_karaf_additional_features_install)
  } else {
    $hiera_karaf_features_install              = $hiera_karaf_base_features_install
  }


  $hiera_mongo_node              = $hiera_mongo_nodes[0]


  #$hiera_mongo_uri               = inline_template('mongodb://<%=@hiera_mongo_admin_user%>:<%=@hiera_mongo_admin_password%>@<%=@hiera_mongo_node%>:27017/<%=@hiera_mongo_db_name%>')

  $hiera_mongo_uri_base  = inline_template("<%= 'mongodb://' + @hiera_mongo_admin_user + ':' + @hiera_mongo_admin_password + '@' + @hiera_mongo_nodes.sort().join(',') + ':27017/'+@hiera_mongo_db_name%>")

  #if we have more the one mongo node then we use replset tic
  if size($hiera_mongo_nodes) > 1 {
    $hiera_mongo_uri = "${hiera_mongo_uri_base}?replicaSet=tipaas"
    $ams_mongo_replica_set_option = present
  } else {
    $hiera_mongo_uri = $hiera_mongo_uri_base
    $ams_mongo_replica_set_option = absent
  }


  #Account management service (AMS) variables

  $hiera_ams_syncope_url                 = inline_template('http://<%=@hiera_ams_syncope_host%>:8080/syncope/rest')
  $hiera_ams_url               = inline_template('http://<%=@hiera_account_manager_nodes.split(",")[0]%>:8181/services/account-management-service')

  #Data transfer service (DTS) variables

  $default_dts_service_node  = $hiera_dts_service_nodes[0]
  $default_dts_service_url = inline_template('http://<%=@default_dts_service_node%>:8181/services/data-transfer-service')

  $default_trial_service_url           = 'unconfigured'
  $hiera_trial_service_url             = inline_template('http://<%=@default_trial_service_nodes.split(",")[0]%>:8181/services/trial-registration-service')
  $default_pe_service_url              = 'unconfigured'
  $hiera_pe_service_url                = inline_template('http://<%=@default_pe_service_nodes.split(",")[0]%>:8181/services/plan-executor-service')

  $flow_execution_log_service_url = "http://${hiera_elasticsearch_host}:${hiera_elasticsearch_port}/"

  # In sub environment 'build' we should not start karaf.
  $env_karaf_service_ensure = $::t_subenv ? {
    'build' => 'stopped',
    default => 'running'
  }

  $default_karaf_service_ensure = pick($karaf_service_ensure, $env_karaf_service_ensure)

  $userdata_json   = { }
  $rt_infra_config = { }

  case $role {
    'engine' : {

      $karaf_base_path = '/opt/talend/ipaas/rt-flow'

      if has_key($userdata_json,'rt_flow_config') {
        $rt_flow_config = $userdata_json['rt_flow_config']
      } else {
        $rt_flow_config = { }
      }

      #validate params
      #FIXME: add some meaningful validation

      if has_key($rt_flow_config, 'account_id') {
        $userdata_account_id = $rt_flow_config['account_id']
      }

      if has_key($rt_flow_config, 'container_id') {
        $userdata_container_id = $rt_flow_config['container_id']
      }

      if has_key($rt_flow_config, 'heartbeat_interval') {
        $userdata_heartbeat_interval = $rt_flow_config['heartbeat_interval']
      }

      if has_key($rt_flow_config, 'queue_input_name') {
        $userdata_queue_input_name = $rt_flow_config['queue_input_name']
      }

      if has_key($rt_flow_config, 'queue_input_consumers_count') {
        $userdata_queue_input_consumers_count = $rt_flow_config['queue_input_consumers_count']
      }

      # move from nexus_url to nexus_urls
      if has_key($rt_flow_config, 'nexus_url') {
        $userdata_nexus_url = $rt_flow_config['nexus_url']
      } else {
        $userdata_nexus_url = $rt_flow_config['nexus_urls']
      }

      if has_key($rt_flow_config, 'nexus_user') {
        $userdata_nexus_user = $rt_flow_config['nexus_user']
      }

      if has_key($rt_flow_config, 'nexus_password_secret') {
        $userdata_nexus_password_secret = $rt_flow_config['nexus_password_secret']
      }

      if has_key($rt_flow_config, 'status_update_interval') {
        $userdata_status_update_interval = $rt_flow_config['status_update_interval']
      }

      if has_key($rt_flow_config, 'activemq_broker_url') {
        $userdata_activemq_broker_url = $rt_flow_config['activemq_broker_url']
      }

      if has_key($rt_flow_config, 'dispatcher_input_queue') {
        $userdata_dispatcher_input_queue = $rt_flow_config['dispatcher_input_queue']
      }

      if has_key($rt_flow_config, 'dispatcher_response_queue') {
        $userdata_dispatcher_response_queue = $rt_flow_config['dispatcher_response_queue']
      }

      if has_key($rt_flow_config, 'flow_manager_url') {
        $userdata_flow_manager_url = $rt_flow_config['flow_manager_url']
      }

      if has_key($rt_flow_config, 'flow_undeploy_after_completed') {
        $userdata_flow_undeploy_after_completed = $rt_flow_config['flow_undeploy_after_completed']
      }

      if has_key($rt_flow_config, 'dts_service_url') {
        $userdata_dts_service_url = $rt_flow_config['dts_service_url']
      }

      if has_key($rt_flow_config, 'queue_response_name') {
        $userdata_queue_response_name = $rt_flow_config['queue_response_name']
      }

      if has_key($rt_flow_config, 'activemq_broker_password_secret') {
        $userdata_activemq_broker_password_secret = $rt_flow_config['activemq_broker_password_secret']
      }

      if has_key($rt_flow_config, 'activemq_broker_username') {
        $userdata_activemq_broker_username = $rt_flow_config['activemq_broker_username']
      }
    }

    'services': {

      $karaf_base_path = '/opt/talend/ipaas/rt-infra'

      $cms_url = "http://${cms_node}:8181/services/container-management-service"
      $config_service_url  = "http://${config_service_node}:8181/services/configuration-service"

      if empty($hiera_zookeeper_nodes) {
        fail('zookeeper nodes list is empty!')
      } else {
        $zookeeper_nodes_list  = split($hiera_zookeeper_nodes, ',')
        $zookeeper_nodes_count = size($zookeeper_nodes_list)
        $hiera_zookeeper_connection    = inline_template("<%= @zookeeper_nodes_list.sort().join(':2181,') + ':2181' %>")
      }

      #get the number of activemq nodes available to us
      #if the number is lower then min_activemq_nodes
      #we won't reconfigure. In other words - wait until we have min nodes, then
      #configure activemq
      if empty($default_activemq_nodes) {

        fail('activemq nodes list is empty!')

      } else {

        $activemq_nodes_list = split($default_activemq_nodes,',')
        $activemq_nodes_count = size($activemq_nodes_list)
        $default_activemq_broker_url = inline_template("<%= 'failover:(tcp://' + @activemq_nodes_list.sort().inject { |url,n|  url + ':61616?keepAlive=true,' + 'tcp://' + n  } + ':61616?keepAlive=true)?jms.prefetchPolicy.queuePrefetch=5'%>")

      }

      #FIXME: here we check if serf is running or we have some local configs
      #in case both are false, we don't start karaf and hope for the next puppet run
      #I assume that puppet will start serf and the node will join the serf cluster
      #then there will be next puppet run (as puppet run on each node join/leave

      if $userdata_nexus_url or $hiera_nexus_nodes {
        $real_karaf_service_ensure = 'running'
      } else {
        $real_karaf_service_ensure = 'stopped'
      }

      if has_key($rt_infra_config, 'karaf_features_install') {
        $userdata_karaf_features_install = $rt_infra_config['karaf_features_install']
      }

      if has_key($rt_infra_config, 'rt_flow_ami_id') {
        $userdata_rt_flow_ami_id = $rt_infra_config['rt_flow_ami_id']
      }

      if has_key($rt_infra_config, 'rt_flow_security_groups') {
        $userdata_rt_flow_security_groups = $rt_infra_config['rt_flow_security_groups']
      }

      if has_key($rt_infra_config, 'rt_flow_subnet') {
        $userdata_rt_flow_subnet = $rt_infra_config['rt_flow_subnet']
      }

      if has_key($rt_infra_config, 'dts_s3_bucket_test_data') {
        $userdata_dts_s3_bucket_test_data = $rt_infra_config['dts_s3_bucket_test_data']
      }

      if has_key($rt_infra_config, 'dts_s3_bucket_rejected_data') {
        $dts_s3_bucket_rejected_data = $rt_infra_config['dts_s3_bucket_rejected_data']
      }

      if has_key($rt_infra_config, 'dts_s3_url_ttl') {
        $userdata_dts_s3_url_ttl = $rt_infra_config['dts_s3_url_ttl']
      }

      if has_key($rt_infra_config, 'dts_max_data_size') {
        $userdata_dts_max_data_size = $rt_infra_config['dts_max_data_size']
      }

      if has_key($rt_infra_config, 'activemq_broker_url') {
        $userdata_activemq_broker_url = $rt_infra_config['activemq_broker_url']
      }

      if has_key($rt_infra_config, 'nexus_url') {
        $userdata_nexus_url = $rt_infra_config['nexus_url']
      }

      if has_key($rt_infra_config, 'rt_flow_instance_profile') {
        $userdata_rt_flow_instance_profile = $rt_infra_config['rt_flow_instance_profile']
      }

      if has_key($rt_infra_config, 'ams_syncope_url') {
        $userdata_ams_syncope_url = $rt_infra_config['ams_syncope_url']
      }

      if has_key($rt_infra_config, 'appversion') {
        $userdata_version = $rt_infra_config['appversion']
      }

      if has_key($rt_infra_config, 're_nexus_url') {
        if $rt_infra_config['re_nexus_url'] != 'nil' {
          $temp_cms_nexus_url = $rt_infra_config['re_nexus_url']
          $nexus_url_scheme = url_parse($temp_cms_nexus_url, 'scheme')
          $nexus_url_host = url_parse($temp_cms_nexus_url, 'host')
          $nexus_url_port = url_parse($temp_cms_nexus_url, 'port')
          $nexus_url_path = url_parse($temp_cms_nexus_url, 'path')
          $userdata_cms_nexus_url = "${nexus_url_scheme}://{{username}}:{{password}}@${nexus_url_host}:${nexus_url_port}${nexus_url_path}/content/repositories/{{accountid}}@id={{accountid}}.release,${nexus_url_scheme}://{{username}}:{{password}}@${nexus_url_host}:${nexus_url_port}${nexus_url_path}/content/repositories/{{accountid}}-snapshots@snapshots@id={{accountid}}.snapshot"
        }
      }

      if has_key($rt_infra_config, 'redis_url') {
        $userdata_webhooks_redis_host_port = split($rt_infra_config['redis_url'],':')
        $userdata_webhooks_redis_host = $userdata_webhooks_redis_host_port[0]
      }

      if has_key($rt_infra_config, 're_amq_broker_url') {
        if $rt_infra_config['re_amq_broker_url'] != 'nil' {
          $userdata_cms_amq_broker_url = $rt_infra_config['re_amq_broker_url']
        }
      }

      if has_key($rt_infra_config, 're_dts_url') {
        if $rt_infra_config['re_dts_url'] != 'nil' {
          $userdata_cms_dts_service_url = $rt_infra_config['re_dts_url']
        }
      }

    }

    'frontend': {

      if has_key($userdata_json,'webapp_config') {
        $webapp_config = $userdata_json['webapp_config']
      } else {
        $webapp_config = { }
      }

      if has_key($webapp_config, 'elasti_cache_endpoint'){
        if $webapp_config['elasti_cache_endpoint'] != 'nil:nil' {
          $userdata_elasticache_address = $webapp_config['elasti_cache_endpoint']
        }
      }

      $cms_url = "http://${cms_node}:8181/services/container-management-service"

    }
    default: {
      notice('unsupported tic role')
    }
  }
}

