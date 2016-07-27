$ec2_userdata    = '{}'
$ec2_instance_id = 'i-foo'
$t_role          = 'services'
$t_profile       = 'ipaas'

packagecloud::repo { 'talend/ticdonotuse':
  type         => 'rpm',
  master_token => $::packagecloud_tic_donotuse_token
} ->
class { '::java':
  distribution => 'jre',
  package      => 'jre1.8.0_60',
  version      => '1.8.0_60-fcs',
} ->
class { 'tic::globals':
  role                               => 'services',
  hiera_dts_s3_bucket_test_data      => 'us-east-1-rd-tipaas-dts-test-talend-com',
  hiera_dts_s3_bucket_rejected_data  => 'us-east-1-rd-tipaas-dts-rejected-talend-com',
  hiera_dts_s3_bucket_logs_data      => 'us-east-1-rd-tipaas-dts-logs-talend-com',
  hiera_dts_s3_bucket_downloads_data => 'us-east-1-rd-tipaas-dts-downloads-talend-com',
  karaf_service_ensure               => running,
  java_xmx                           => 1024,
  web_enable_test_context            => false,
  web_use_ssl                        => true,
  cms_node                           => 'testcmsnode',
  java_home                          => '/usr/java/jre1.8.0_60',
  activemq_broker_username           => 'activemq_broker_test_username',
  activemq_broker_password           => 'activemq_broker_test_password',
} ->
class { 'tic': }
