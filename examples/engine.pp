packagecloud::repo { 'talend/other':
  type         => 'rpm',
  master_token => $::packagecloud_master_token
} ->
class { '::java':
  distribution => 'jre',
  package      => 'jre1.8.0_60',
  version      => '1.8.0_60-fcs',
} ->
class { '::tic::engine':
  java_home          => '/usr/java/jre1.8.0_60',
  rt_flow_lxc_enable => true,
}
