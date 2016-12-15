packagecloud::repo { 'talend/ticdonotuse':
  type         => 'rpm',
  master_token => $::packagecloud_tic_donotuse_token
} ->
class { '::java':
  distribution => 'jre',
  package      => 'jre1.8.0_60',
  version      => '1.8.0_60-fcs',
} ->
class { '::tic::services':
  java_home                       => '/usr/java/jre1.8.0_60',
  activemq_broker_username        => 'activemq_broker_test_username',
  activemq_broker_password        => 'activemq_broker_test_password',
  pe_service_username             => 'pe_service_test_username',
  rt_flow_ami_id                  => 'test-ami-id',
  rt_flow_security_groups         => 'test-security-groups',
  rt_flow_instance_type           => 'test-instance-type',
  rt_flow_subnet_id               => 'test-subnet-id',
  rt_flow_t_environment           => 'test_env',
  karaf_service_ensure            => 'running',
  karaf_service_enable            => true,
  osgi_http_service_port          => 8282,
  logs_transfer_client_admin_url  => 'logs_admin_url',
  logs_transfer_client_username   => 'logs_admin_username',
  logs_transfer_client_password   => 'logs_admin_password',
  logs_transfer_client_upload_url => 'logs_upload_url',
  karaf_features_install          => [
    'plan_executor_client',
    'plan_executor_client',
    'non_existing_feature',
    'logs-transfer-service-client',
    'dispatcher_core'
  ],
}
