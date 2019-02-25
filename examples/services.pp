packagecloud::repo { 'talend/other':
  type         => 'rpm',
  master_token => $::packagecloud_master_token
} ->
class { '::java':
  distribution => 'jre',
  package      => 'jre1.8.0_60',
  version      => '1.8.0_60-fcs',
} ->
class { '::tic::services':
  java_home                                => '/usr/java/jre1.8.0_60',
  activemq_broker_username                 => 'activemq_broker_test_username',
  activemq_broker_password                 => 'activemq_broker_test_password',
  pe_service_username                      => 'pe_service_test_username',
  rt_flow_ami_id                           => 'test-ami-id',
  rt_flow_security_groups                  => 'test-security-groups',
  rt_flow_instance_type                    => 'test-instance-type',
  rt_flow_subnet_id                        => 'test-subnet-id',
  rt_flow_t_environment                    => 'test_env',
  karaf_service_ensure                     => 'running',
  karaf_service_enable                     => true,
  osgi_http_service_port                   => 8282,
  logs_transfer_client_admin_url           => 'logs_admin_url',
  logs_transfer_client_username            => 'logs_admin_username',
  logs_transfer_client_password            => 'logs_admin_password',
  logs_transfer_client_upload_url          => 'logs_upload_url',
  notification_subscription_memcached_host => 'my-memcached-host',
  notification_subscription_memcached_port => 'my-memcached-port',
  zookeeper_prefix                         => '/zookeeper/path/prefix',
  quartz_scheduler_instance_id             => 'my-instance-id',
  quartz_jobstore_isclustered              => false,
  quartz_jobstore_cluster_check_interval   => 777,
  iam_service_url                          => 'iam-test-url',
  scim_service_url                         => 'http://scim-test-node',
  karaf_features_install                   => [
    'tipaas-bookkeeper-service',
    'tipaas-notification-subscription-service',
    'plan_executor_client',
    'plan_executor_client',
    'non_existing_feature',
    'logs-transfer-service-client',
    'tipaas-scheduler',
    'dispatcher_core',
    'tipaas-account-manager-service',
    'tipaas-flow-manager-service',
    'tipaas-webhooks-client',
    'kafkasource',
  ],
  time_to_unknown                          => 999,
  zipkin_enabled                           => true,
  zipkin_kafka_topic                       => 'zipkin',
  zipkin_kafka_servers                     => 'localhost:9999',
  zipkin_sampling_rate                     => '0.3',
  webhooks_url                             => 'webhook-url-for-client',
  webhooks_external_url                    => 'webhook-test-url',
  license_service_url                      => 'http://license-management-node',
  eventsource_kafka_servers                => 'localhost:9092',
  eventsource_kafka_topic                  => 'provisioning',
  eventsource_kafka_log                    => true,
  kafka_apps_servers                       => 'localhost:9092',
  kafka_apps_topic                         => 'app-to-runtime',
  kafka_statuses_hosts                     => 'localhost:9092',
  kafka_statuses_topic                     => 'events-to-platform',
  dispatcher_redis_host                    => 'dispatcher-redis',
  dispatcher_redis_port                    => 1234,
  vault_url                                => 'http://localhost:8200',
  vault_ipaas_role_id                      => 'e9d94f22-7ebc-f753-4a00-1520fc4089ce',
  vault_ipaas_secret_id                    => 'somesecret',
}
