class tic::services::features::crypto_service_core {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  file { '/opt/talend/ipaas/.crypto':
      ensure => directory,
      owner  => 'ipaassrv',
      group  => 'ipaasgrp',
      mode   => '0600'
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.crypto.core.cfg":
    settings => {
      'master.key.alias'  => $tic::services::params::kms_key_alias,
      'current.region'    => $tic::services::params::crypto_current_region,
      'secondary.regions' => $tic::services::params::crypto_secondary_regions,
      'db.host'           => $tic::services::params::crypto_db_host,
      'db.password'       => $tic::services::params::crypto_db_password,
    }
  }

}
