class tic::services::features::dispatcher_core {

  $rt_aws_region                 = $tic::services::params::rt_aws_region
  $subenv_prefix                 = $tic::services::params::subenv_prefix
  $flow_undeploy_after_completed = $tic::services::params::flow_undeploy_after_completed
  $dts_service_url               = $tic::services::params::dts_service_url
  $activemq_broker_url           = $tic::services::params::activemq_broker_url

  file {'/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.dispatcher.nodemanager.aws.cfg':
    content => template('tic/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.dispatcher.nodemanager.aws.cfg.erb'),
    owner   => 'ipaassrv',
    group   => 'ipaasgrp',
    #TODO : notify  => Service['rt-infra-service']
  }

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { 'dispatcher':
    path     => "${config_dir}/org.talend.ipaas.rt.dispatcher.core.cfg",
    settings => {
      'queue.input.name'    => "ipaas.${tic::services::params::subenv_prefix}.dispatcher.input.queue"   ,
      'queue.response.name' => "ipaas.${tic::services::params::subenv_prefix}.dispatcher.response.queue",
    }
  }

}
