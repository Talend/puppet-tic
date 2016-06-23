$ec2_userdata    = '{}'
$ec2_instance_id = 'i-foo'
$t_role          = 'frontend'
$t_profile       = 'ipaas'

packagecloud::repo { 'talend/ticdonotuse':
  type         => 'rpm',
  master_token => $::packagecloud_tic_donotuse_token
} ->
class { 'tic::globals':
  role                    => 'frontend',
  java_xmx                => 1024,
  web_enable_test_context => false,
  web_use_ssl             => true,
  cms_node                => 'testcmsnode'
} ->
class { 'tic': }
