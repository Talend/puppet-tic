class tic::engine (

  $java_home               = undef,
  $java_xmx                = undef,
  $version                 = undef,
  $manage_packages         = undef,
  $rt_flow_lxc_enable      = undef,
  $rt_flow_purge_puppet    = undef,
  $wrapper_diable_restarts = undef,
  $logging_level           = undef,
  $karaf_base_path         = undef,
  $jmx_enabled             = undef,
  $heartbeat_interval      = undef,
  $log_amq_messages        = undef,

  $karaf_features_install = undef,

  $account_id   = undef,
  $container_id = undef,

  $activemq_nodes           = undef,
  $nexus_nodes              = undef,
  $dts_service_node         = undef,

  $activemq_broker_url      = undef,
  $activemq_broker_username = undef,
  $activemq_broker_password = undef,

  $activemq_log_internal_dns = undef,
  $activemq_log_broker_url   = undef,

  $dispatcher_input_queue    = undef,
  $dispatcher_response_queue = undef,

  $nexus_urls                     = undef,
  $nexus_user                     = undef,
  $nexus_password                 = undef,
  $userdata_nexus_password_secret = undef,

  $queue_input_name              = undef,
  $queue_response_name           = undef,
  $queue_input_consumers_count   = undef,
  $flow_undeploy_after_completed = undef,

  $dts_service_url = undef,

) {

  contain tic::engine::params
  contain tic::engine::install
  contain tic::engine::storage

  # in case we are in build subenv we don't instantiate the config and service classes
  if $::t_subenv == 'build' {
    contain tic::engine::lxc
  } else {
    contain tic::engine::config
    # TODO : contain tic::engine::lxc_dns
    contain tic::engine::service
  }

}
