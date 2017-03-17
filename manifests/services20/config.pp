class tic::services20::config {

  require ::tic::services::install

  validate_array($tic::services20::params::karaf_features_install)

  $config_dir = '/opt/talend/ipaas/rt-infra/etc'

  $features = unique($tic::services20::params::karaf_features_install)

  if 'tipaas-account-manager-service' in $features {
    tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.iam.scim.client.cfg":
      settings => {
        'iam.service.url'  => $tic::services20::params::iam_service_url,
        'scim.service.url' => $tic::services20::params::scim_service_url,
      }
    }
  }

}
