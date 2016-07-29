packagecloud::repo { 'talend/ticdonotuse':
  type         => 'rpm',
  master_token => $::packagecloud_tic_donotuse_token
} ->
class { '::java':
  distribution => 'jre',
  package      => 'jre1.8.0_60',
  version      => '1.8.0_60-fcs',
} ->
class { '::tic::frontend':
  java_home               => '/usr/java/jre1.8.0_60',
  java_xmx                => 1024,
  web_enable_test_context => false,
  web_use_ssl             => true,
  cms_node                => 'testcmsnode',
  elasticache_address     => 'some_elasticache_address',
}
