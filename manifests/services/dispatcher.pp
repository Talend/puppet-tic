class tic::services::dispatcher {
  file {'/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.dispatcher.nodemanager.aws.cfg':
    content => template('tic/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.dispatcher.nodemanager.aws.cfg.erb'),
    owner   => 'ipaassrv',
    group   => 'ipaasgrp',
    notify  => Service['rt-infra-service']
  }

  tic::ini_settings { 'dispatcher':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.dispatcher.core.cfg",
    settings => {
      'queue.input.name'    => "ipaas.${tic::subenv_prefix}.dispatcher.input.queue"   ,
      'queue.response.name' => "ipaas.${tic::subenv_prefix}.dispatcher.response.queue",
    }
  }
}
