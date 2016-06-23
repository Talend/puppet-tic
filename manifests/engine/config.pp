# config class for the rt_flow
class tic::engine::config {

  $config_dir = "${tic::karaf_base_path}/etc"

  $mvn_repositories = "${tic::nexus_url}/content/repositories/${tic::account_id}@id=${tic::account_id}.release, ${tic::nexus_url}/content/repositories/${tic::account_id}-snapshots@snapshots@id=${tic::account_id}.snapshot, file:/opt/talend/ipaas/rt-flow/data/kar@id=kar.repository@multi"

  #Decrypt
  $nexus_password = $tic::userdata_nexus_password_secret

  file {
    '/opt/talend/ipaas/.m2':
      ensure => directory,
      owner  => 'ipaassrv',
      group  => 'ipaasgrp';

    '/opt/talend/ipaas/.m2/settings.xml':
      content => template('tic/opt/talend/ipaas/m2/settings.xml.erb'),
      owner   => 'ipaassrv',
      group   => 'ipaasgrp',
      require => File['/opt/talend/ipaas/.m2']
  }

  ini_setting {

    'karaf_featuresBoot':
      ensure  => present,
      path    => "${config_dir}/org.apache.karaf.features.cfg",
      section => '',
      setting => 'featuresBoot',
      value   => $tic::karaf_boot_features_real;

    'account_id':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.deployment.agent.cfg",
      section => '',
      setting => 'account.id',
      value   => $tic::account_id;

    'container_id':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.deployment.agent.cfg",
      section => '',
      setting => 'container.id',
      value   => $tic::container_id;

    'container_id_heartbeat':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.heartbeat.sender.cloud.cfg",
      section => '',
      setting => 'container.id',
      value   => $tic::container_id;

    'account_id_heartbeat':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.heartbeat.sender.cloud.cfg",
      section => '',
      setting => 'account.id',
      value   => $tic::account_id;

    'heartbeat_interval':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.heartbeat.sender.cloud.cfg",
      section => '',
      setting => 'heartbeat.interval',
      value   => $tic::heartbeat_interval;

    'queue_input_name':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.deployment.agent.cfg",
      section => '',
      setting => 'queue.input.name',
      value   => $tic::queue_input_name;

    'queue_response_name':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.deployment.agent.cfg",
      section => '',
      setting => 'queue.response.name',
      value   => $tic::queue_response_name;

    'queue_input_consumers_count':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.deployment.agent.cfg",
      section => '',
      setting => 'queue.input.consumers.count',
      value   => $tic::queue_input_consumers_count;

    'mvn_repositories':
      ensure  => present,
      path    => "${config_dir}/org.ops4j.pax.url.mvn.cfg",
      section => '',
      setting => 'org.ops4j.pax.url.mvn.repositories',
      value   => '';

    'mvn_settings':
      ensure  => present,
      path    => "${config_dir}/org.ops4j.pax.url.mvn.cfg",
      section => '',
      setting => 'org.ops4j.pax.url.mvn.settings',
      value   => '/opt/talend/ipaas/.m2/settings.xml';

    'flow_undeploy_after_completed':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.deployment.agent.cfg",
      section => '',
      setting => 'flow.undeploy.after.completed',
      value   => $tic::flow_undeploy_after_completed;

    'dispatcher_input_queue':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.dispatcher.client.cfg",
      section => '',
      setting => 'dispatcher.input.queue',
      value   => $tic::dispatcher_input_queue;

    'dispatcher_response_queue':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.dispatcher.client.cfg",
      section => '',
      setting => 'dispatcher.response.queue',
      value   => $tic::dispatcher_response_queue;

    'activemq_broker_url':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
      section => '',
      setting => 'activemq.broker.url',
      value   => $tic::activemq_broker_url;

    'activemq_broker_username':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
      section => '',
      setting => 'activemq.broker.username',
      value   => $tic::activemq_broker_username;

    'activemq_broker_password':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
      section => '',
      setting => 'activemq.broker.password',
      value   => $tic::activemq_broker_password;


    'eventlogging_jms_url':
      ensure  => present,
      path    => "${config_dir}/org.talend.eventlogging.sender.jms.cfg",
      section => '',
      setting => 'sender.destination.jms.url',
      value   => $tic::activemq_broker_url;

    'dts_service_url':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.dts.client.cfg",
      section => '',
      setting => 'dts.service.url',
      value   => $tic::dts_service_url;

    'eventlogging_destination':
      ensure  => present,
      path    => "${config_dir}/org.talend.eventlogging.agent.cfg",
      section => '',
      setting => 'agent.sender.destination.default',
      value   => 'eventlogsenderjms';

    'agent_id':
      ensure  => present,
      path    => "${config_dir}/org.talend.eventlogging.agent.cfg",
      section => '',
      setting => 'agentid',
      value   => $tic::account_id;

    'custom_info_container_id':
      ensure  => present,
      path    => "${config_dir}/org.talend.eventlogging.agent.cfg",
      section => '',
      setting => 'event.add.customInfo.containerID',
      value   => $tic::container_id;

    'custom_info_account_id':
      ensure  => present,
      path    => "${config_dir}/org.talend.eventlogging.agent.cfg",
      section => '',
      setting => 'event.add.customInfo.accountID',
      value   => $tic::account_id;

    'debug_logging_flow':
      ensure  => present,
      path    => "${config_dir}/org.ops4j.pax.logging.cfg",
      section => '',
      setting => 'log4j.logger.org.talend.ipaas',
      value   => $tic::logging_level;

    'log_amq_messages_flow':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
      section => '',
      setting => 'log.messages',
      value   => $tic::log_amq_messages;
  }

  if $tic::karaf_rmiRegistryPort {
    ini_setting { 'karaf_rmiRegistryPort':
      ensure  => present,
      path    => "${config_dir}/org.apache.karaf.management.cfg",
      section => '',
      setting => 'rmiRegistryPort',
      value   => $tic::karaf_rmiRegistryPort;
    }
  }

  if $tic::karaf_rmiServerPort {
    ini_setting { 'karaf_rmiServerPort':
      ensure  => present,
      path    => "${config_dir}/org.apache.karaf.management.cfg",
      section => '',
      setting => 'rmiServerPort',
      value   => $tic::karaf_rmiServerPort;
    }
  }

  if $tic::karaf_httpPort {
    ini_setting { 'karaf_httpPort':
      ensure  => present,
      path    => "${config_dir}/org.ops4j.pax.web.cfg",
      section => '',
      setting => 'org.osgi.service.http.port',
      value   => $tic::karaf_httpPort;
    }
  }

  if $tic::karaf_httpsPort {
    ini_setting { 'karaf_httpsPort':
      ensure  => present,
      path    => "${config_dir}/org.ops4j.pax.web.cfg",
      section => '',
      setting => 'org.osgi.service.http.port.secure',
      value   => $tic::karaf_httpsPort;
    }
  }

  if $tic::karaf_sshPort {
    ini_setting { 'karaf_sshPort':
      ensure  => present,
      path    => "${config_dir}/org.apache.karaf.shell.cfg",
      section => '',
      setting => 'sshPort',
      value   => $tic::karaf_sshPort;
    }
  }

  if $tic::karaf_command_server_port {
    ini_setting { 'karaf_command_server_port':
      ensure  => present,
      path    => "${config_dir}/org.talend.remote.jobserver.server.cfg",
      section => '',
      setting => 'org.talend.remote.jobserver.server.TalendJobServer.COMMAND_SERVER_PORT',
      value   => $tic::karaf_command_server_port;
    }
  }

  if $tic::karaf_file_server_port {
    ini_setting { 'karaf_file_server_port':
      ensure  => present,
      path    => "${config_dir}/org.talend.remote.jobserver.server.cfg",
      section => '',
      setting => 'org.talend.remote.jobserver.server.TalendJobServer.FILE_SERVER_PORT',
      value   => $tic::karaf_file_server_port;
    }
  }

  if $tic::karaf_monitoring_port {
    ini_setting { 'karaf_monitoring_port':
      ensure  => present,
      path    => "${config_dir}/org.talend.remote.jobserver.server.cfg",
      section => '',
      setting => 'org.talend.remote.jobserver.server.TalendJobServer.MONITORING_PORT',
      value   => $tic::karaf_monitoring_port;
    }
  }
}

