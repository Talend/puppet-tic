#this is a private class that installs the flow runtime
class tic::engine::install {
  if $tic::manage_packages {
    package {'talend-ipaas-rt-flow':
      ensure => $tic::version
    }
  }
  file {
    '/opt/talend/ipaas/rt-flow/scripts/oomkiller4j.sh':
      source  => 'puppet:///modules/tic/opt/talend/ipaas/rt-flow/scripts/oomkiller4j.sh',
      mode    => '0750',
      owner   => 'ipaassrv',
      group   => 'ipaasgrp',
      require => Package['talend-ipaas-rt-flow'];

    '/opt/talend/ipaas/rt-flow/scripts/unregister':
      content => template('tic/opt/talend/ipaas/rt-flow/scripts/unregister.erb'),
      mode    => '0750',
      owner   => 'ipaassrv',
      group   => 'ipaasgrp',
      require => Package['talend-ipaas-rt-flow']
  }
}
