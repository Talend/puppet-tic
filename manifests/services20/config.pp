class tic::services20::config {

  require ::tic::services::install

  validate_array($tic::services20::params::karaf_features_install)

  $config_dir = '/opt/talend/ipaas/rt-infra/etc'

  $features = unique($tic::services20::params::karaf_features_install)

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.iam.scim.client.cfg":
    settings => {
      'iam.service.url'  => $tic::services20::params::iam_service_url,
      'scim.service.url' => $tic::services20::params::scim_service_url,
    }
  }

  if 'tipaas-tpsvc-crypto-client' in $features {
    tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.tpsvc.crypto.client.cfg":
      settings => {
        'crypto.tpsvc.service.url' => $tic::services20::params::crypto_service_url
      }
    }
  }

  if 'tpsvc-config-client' in $features {
    tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.tpsvc.config.client.cfg":
      settings => {
        'config.service.url' => $tic::services20::params::config_service_url
      }
    }
  }

  tic::ini_settings { 'Ensuring new log4j configuration':
    ensure   => present,
    path     => "${config_dir}/org.ops4j.pax.logging.cfg",
    settings => {
      'log4j2.logger.ipaas.name'  => 'org.talend.ipaas',
      'log4j2.logger.ipaas.level' => $tic::services::params::logging_level,
    }
  }

  tic::ini_settings { 'ensuring minConnectionsPerHost':
    ensure   => present,
    path     => "${config_dir}/org.talend.ipaas.rt.mongo.common.cfg",
    settings => {
      'minConnectionsPerHost' => '0',
    }
  }

}
