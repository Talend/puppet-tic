class tic::engine::install {

  if $tic::engine::params::manage_packages {
    package { 'talend-ipaas-rt-flow':
      ensure => $tic::engine::params::version
    }
  }

  $karaf_base_path           = $tic::engine::params::karaf_base_path
  $java_home                 = $tic::engine::params::java_home
  $account_id                = $tic::engine::params::account_id
  $container_id              = $tic::engine::params::container_id
  $activemq_broker_username  = $tic::engine::params::activemq_broker_username
  $activemq_broker_password  = $tic::engine::params::activemq_broker_password
  $activemq_broker_url       = $tic::engine::params::activemq_broker_url
  $dispatcher_response_queue = $tic::engine::params::dispatcher_response_queue

  file {
    '/opt/talend/ipaas/rt-flow/scripts/oomkiller4j.sh':
      source  => 'puppet:///modules/tic/opt/talend/ipaas/rt-flow/scripts/oomkiller4j.sh',
      mode    => '0750',
      owner   => 'ipaassrv',
      group   => 'ipaasgrp',

    '/opt/talend/ipaas/rt-flow/scripts/unregister':
      content => template('tic/opt/talend/ipaas/rt-flow/scripts/unregister.erb'),
      mode    => '0750',
      owner   => 'ipaassrv',
      group   => 'ipaasgrp',
  }

}
