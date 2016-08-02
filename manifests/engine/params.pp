class tic::engine::params {


  $java_home       = pick($tic::engine::java_home, undef)
  $java_xmx        = pick($tic::engine::java_xmx,  '1024')
  $version         = pick($tic::engine::version,   'latest')
  $manage_packages = pick($tic::engine::manage_packages, true)
  $rt_flow_lxc_enable = pick($tic::engine::rt_flow_lxc_enable, true)
  $rt_flow_purge_puppet = pick($tic::engine::rt_flow_purge_puppet, true)
  $wrapper_diable_restarts = pick($tic::engine::wrapper_diable_restarts, true)

  $karaf_base_path = pick($tic::engine::karaf_base_path, '/opt/talend/ipaas/rt-flow')
  $jmx_enabled = pick($tic::engine::jmx_enabled, false)

  $karaf_features_install = pick(
    $tic::engine::karaf_features_install,
    []
  )
  $karaf_boot_features_real = join($karaf_features_install, ',')

  $account_id = pick($tic::engine::account_id, 'talend')
  $container_id = pick($tic::engine::container_id, 'default_container_id')




  $activemq_nodes           = pick($tic::engine::activemq_nodes,           'localhost')




  $activemq_nodes_list      = split($activemq_nodes, ',')
  $activemq_broker_url    = pick($tic::engine::activemq_broker_url, inline_template("<%= 'failover:(tcp://' + @activemq_nodes_list.sort().inject { |url,n| url + ':61616?keepAlive=true,' + 'tcp://' + n } + ':61616?keepAlive=true)?jms.prefetchPolicy.queuePrefetch=5'%>"))
  $activemq_broker_username = pick($tic::engine::activemq_broker_username, 'tadmin')
  $activemq_broker_password = pick($tic::engine::activemq_broker_password, 'missing')



  $dispatcher_input_queue    = pick($tic::engine::dispatcher_input_queue,    'ipaas.dispatcher.input.queue')
  $dispatcher_response_queue = pick($tic::engine::dispatcher_response_queue, 'ipaas.dispatcher.response.queue')



  $nexus_nodes              = pick($tic::engine::nexus_nodes,              'localhost')
  $nexus_urls             = pick($tic::engine::nexus_urls, inline_template('<%= @nexus_nodes.split(",").map { |a| "http://"+a+":8081/nexus" }.join(",") %>'))


  $userdata_nexus_password_secret           = pick($tic::engine::userdata_nexus_password_secret,           'missing')


  $queue_input_name              = pick($tic::engine::queue_input_name,              'missing')
  $queue_response_name           = pick($tic::engine::queue_response_name,           'missing')
  $queue_input_consumers_count   = pick($tic::engine::queue_input_consumers_count,   5)
  $flow_undeploy_after_completed = pick($tic::engine::flow_undeploy_after_completed, true)

  $heartbeat_interval = pick($tic::engine::heartbeat_interval, '180')


  $log_amq_messages = pick($tic::engine::log_amq_messages, false)



  $dts_service_node         = pick($tic::services::dts_service_node,         'localhost')
  $dts_service_url        = pick($tic::services::dts_service_url, inline_template('http://<%= @dts_service_node %>:8181/services/data-transfer-service'))


  $logging_level    = pick($tic::services::logging_level,    'INFO')










}
