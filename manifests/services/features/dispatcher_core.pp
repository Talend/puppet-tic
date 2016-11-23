class tic::services::features::dispatcher_core {

  $rt_aws_region                 = $tic::services::params::rt_aws_region
  $subenv_prefix                 = $tic::services::params::subenv_prefix
  $flow_undeploy_after_completed = $tic::services::params::flow_undeploy_after_completed
  $dts_service_url               = $tic::services::params::dts_service_url
  $lts_service_url               = $tic::services::params::lts_service_url
  $activemq_broker_url           = $tic::services::params::activemq_broker_url
  $cms_nexus_url                 = $tic::services::params::cms_nexus_url
  $dispatcher_nexus_url          = $tic::services::params::dispatcher_nexus_url

  $t_dc          = $tic::services::params::rt_flow_t_dc
  $t_environment = $tic::services::params::rt_flow_t_environment
  $t_release     = $tic::services::params::rt_flow_t_release
  $t_profile     = $tic::services::params::rt_flow_t_profile
  $t_subenv      = $tic::services::params::rt_flow_t_subenv

  if $tic::services::params::activemq_nodes_count >= $tic::services::params::min_activemq_brokers {
    file {'/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.dispatcher.nodemanager.aws.cfg':
      content => template('tic/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.dispatcher.nodemanager.aws.cfg.erb'),
      owner   => 'ipaassrv',
      group   => 'ipaasgrp',
    }
  }

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.dispatcher.core.cfg":
    settings => {
      'queue.input.name'    => "ipaas.${tic::services::params::subenv_prefix}.dispatcher.input.queue"   ,
      'queue.response.name' => "ipaas.${tic::services::params::subenv_prefix}.dispatcher.response.queue",
    }
  }

}
