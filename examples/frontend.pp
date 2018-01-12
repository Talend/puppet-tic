packagecloud::repo { 'talend/other':
  type         => 'rpm',
  master_token => $::packagecloud_master_token
} ->
class { '::java':
  distribution => 'jre',
  package      => 'jre1.8.0_60',
  version      => '1.8.0_60-fcs',
} ->
class { '::tic::frontend':
  java_home                    => '/usr/java/jre1.8.0_60',
  java_xmx                     => 1024,
  web_enable_test_context      => false,
  web_use_ssl                  => true,
  cms_node                     => 'testcmsnode',
  elasticache_address          => 'some_elasticache_address',
  flow_manager_nodes           => 'flow_manager_node',
  flow_manager_url             => 'http://flow_manager_url',
  redis_session_host           => 'redis-host',
  redis_session_port           => 8888,
  redis_session_namespace      => 'redis-namespace',
  scim_service_node            => 'scim-test-node',
  client_app_oidc_clientId     => 'client_clientId',
  client_app_oidc_clientSecret => 'client_clientSecret',
  server_app_oidc_clientId     => 'server_clientId',
  server_app_oidc_clientSecret => 'server_clientSecret',
  workspace_url                => '123456',
  marketplace_url              => '123456',
  tcomp_static_ips             => '890,123,321',
  pendo_enabled                => true,
  pendo_ipaas_key              => 'asdfgh',
  pendo_cloud_provider         => 'MyCloud',
  pendo_region                 => 'PENDO-REGION',
  zipkin_enabled               => true,
  zipkin_kafka_topic           => 'zipkin',
  zipkin_kafka_servers         => 'localhost:9999',
  zipkin_sampling_rate         => '0.2',
}
