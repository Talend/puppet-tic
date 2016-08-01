class tic::services::features::crypto_service_core {

  file {
    '/opt/talend/ipaas/.crypto':
      ensure => directory,
      owner  => 'ipaassrv',
      group  => 'ipaasgrp',
      mode   => '0600'
  }

  tic::ini_settings { 'crypto_service':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.crypto.core.cfg",
    settings => {
      'master.key.alias'  => $tic::kms_key_alias,
      'current.region'    => '',
      'secondary.regions' => $tic::crypto_secondary_regions,
      'db.host'           => $tic::crypto_db_host,
      'db.password'       => $tic::crypto_db_password,
    }
  }

}
