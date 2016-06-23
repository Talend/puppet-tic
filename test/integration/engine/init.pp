$ec2_userdata    = '{}'
$ec2_instance_id = 'i-foo'
$t_role          = 'engine'
$t_profile       = 'ipaas'
$t_subenv        = 'build'

packagecloud::repo { 'talend/ticdonotuse':
  type         => 'rpm',
  master_token => $::packagecloud_tic_donotuse_token
} ->
class { '::java':
  distribution => 'jre',
  package      => 'jre1.8.0_60',
  version      => '1.8.0_60-fcs',
} ->
file {
  '/etc/facter':
    ensure => directory;
  '/etc/facter/facts.d':
    ensure => directory;
} ->
file { '/etc/sysconfig/clock':
  ensure  => present,
  content => "
UTC=true
ZONE=UTC
"
} ->
package { 'epel-release':
  ensure => installed,
} ->
class { 'tic::globals':
  role               => 'engine',
  rt_flow_lxc_enable => true,
  java_home          => '/usr/java/jre1.8.0_60/',
  java_xmx           => 1024,
} ->
class { 'tic':
  jmx_enabled => true,
} ->
exec { 'start rt-flow-service-lxc':
  command => '/usr/sbin/service rt-flow-service-lxc start',
}
