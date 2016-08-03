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
  java_home                => '/usr/java/jre1.8.0_60',
  activemq_broker_username => 'activemq_broker_test_username',
  activemq_broker_password => 'activemq_broker_test_password',
  pe_service_username      => 'pe_service_test_username',
  karaf_features_install   => [
    'plan_executor_client',
    'plan_executor_client',
    'non_existing_feature'
  ],
}
