# config class for the rt_flow
class tic::engine::config {

  $config_dir = "${tic::engine::params::karaf_base_path}/etc"

  $mvn_repositories = "${tic::engine::params::nexus_urls}/content/repositories/${tic::engine::params::account_id}@id=${tic::engine::params::account_id}.release, ${tic::engine::params::nexus_urls}/content/repositories/${tic::engine::params::account_id}-snapshots@snapshots@id=${tic::engine::params::account_id}.snapshot, file:/opt/talend/ipaas/rt-flow/data/kar@id=kar.repository@multi"

  #Decrypt
  $nexus_password = $tic::engine::params::userdata_nexus_password_secret
  $nexus_urls     = $tic::engine::params::nexus_urls
  $account_id     = $tic::engine::params::account_id

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

  tic::ini_settings { "${config_dir}/org.apache.karaf.features.cfg":
    settings => {
      'featuresBoot' => $tic::engine::params::karaf_boot_features_real,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.deployment.agent.cfg":
    settings => {
      'account.id'                    => $tic::engine::params::account_id,
      'container.id'                  => $tic::engine::params::container_id,
      'queue.input.name'              => $tic::engine::params::queue_input_name,
      'queue.response.name'           => $tic::engine::params::queue_response_name,
      'queue.input.consumers.count'   => $tic::engine::params::queue_input_consumers_count,
      'flow.undeploy.after.completed' => $tic::engine::params::flow_undeploy_after_completed,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.heartbeat.sender.cloud.cfg":
    settings => {
      'container.id'       => $tic::engine::params::container_id,
      'account.id'         => $tic::engine::params::account_id,
      'heartbeat.interval' => $tic::engine::params::heartbeat_interval,
    }
  }

  tic::ini_settings { "${config_dir}/org.ops4j.pax.url.mvn.cfg":
    settings => {
      'org.ops4j.pax.url.mvn.repositories' => '',
      'org.ops4j.pax.url.mvn.settings'     => '/opt/talend/ipaas/.m2/settings.xml',
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.dispatcher.client.cfg":
    settings => {
      'dispatcher.input.queue'    => $tic::engine::params::dispatcher_input_queue,
      'dispatcher.response.queue' => $tic::engine::params::dispatcher_response_queue,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg":
    settings => {
      'activemq.broker.url'      => $tic::engine::params::activemq_broker_url,
      'activemq.broker.username' => $tic::engine::params::activemq_broker_username,
      'activemq.broker.password' => $tic::engine::params::activemq_broker_password,
      'log.messages'             => $tic::engine::params::log_amq_messages,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.eventlogging.sender.jms.cfg":
    settings => {
      'sender.destination.jms.url' => $tic::engine::params::activemq_broker_url,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.dts.client.cfg":
    settings => {
      'dts.service.url' => $tic::engine::params::dts_service_url,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.eventlogging.agent.cfg":
    settings => {
      'agent.sender.destination.default' => 'eventlogsenderjms',
      'agentid'                          => $tic::engine::params::account_id,
      'event.add.customInfo.containerID' => $tic::engine::params::container_id,
      'event.add.customInfo.accountID'   => $tic::engine::params::account_id,
    }
  }

  tic::ini_settings { "${config_dir}/org.ops4j.pax.logging.cfg":
    settings => {
      'log4j.logger.org.talend.ipaas' => $tic::engine::params::logging_level,
    }
  }


  if $tic::engine::params::karaf_rmiRegistryPort {
    tic::ini_settings { "${config_dir}/org.apache.karaf.management.cfg":
      settings => {
        'rmiRegistryPort' => $tic::engine::params::karaf_rmiRegistryPort,
      }
    }
  }

  if $tic::engine::params::karaf_rmiServerPort {
    tic::ini_settings { "${config_dir}/org.apache.karaf.management.cfg":
      settings => {
        'rmiServerPort' => $tic::engine::params::karaf_rmiServerPort,
      }
    }
  }

  if $tic::engine::params::karaf_httpPort {
    tic::ini_settings { "${config_dir}/org.ops4j.pax.web.cfg":
      settings => {
        'org.osgi.service.http.port' => $tic::engine::params::karaf_httpPort,
      }
    }
  }

  if $tic::engine::params::karaf_httpsPort {
    tic::ini_settings { "${config_dir}/org.ops4j.pax.web.cfg":
      settings => {
        'org.osgi.service.http.port.secure' => $tic::engine::params::karaf_httpsPort,
      }
    }
  }

  if $tic::engine::params::karaf_sshPort {
    tic::ini_settings { "${config_dir}/org.apache.karaf.shell.cfg":
      settings => {
        'sshPort' => $tic::engine::params::karaf_sshPort,
      }
    }
  }

  if $tic::engine::params::karaf_command_server_port {
    tic::ini_settings { "${config_dir}/org.talend.remote.jobserver.server.cfg":
      settings => {
        'org.talend.remote.jobserver.server.TalendJobServer.COMMAND_SERVER_PORT' => $tic::engine::params::karaf_command_server_port,
      }
    }
  }

  if $tic::engine::params::karaf_file_server_port {
    tic::ini_settings { "${config_dir}/org.talend.remote.jobserver.server.cfg":
      settings => {
        'org.talend.remote.jobserver.server.TalendJobServer.FILE_SERVER_PORT' => $tic::engine::params::karaf_file_server_port,
      }
    }
  }

  if $tic::engine::params::karaf_monitoring_port {
    tic::ini_settings { "${config_dir}/org.talend.remote.jobserver.server.cfg":
      settings => {
        'org.talend.remote.jobserver.server.TalendJobServer.MONITORING_PORT' => $tic::engine::params::karaf_monitoring_port,
      }
    }
  }

}
