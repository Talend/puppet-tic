class tic::services20::config {

  require ::tic::services::install

  validate_array($tic::services20::karaf_features_install)

  $config_dir = '/opt/talend/ipaas/rt-infra/etc'

  $features = unique($tic::services20::karaf_features_install)

  if 'tipaas-account-manager-service' in $features {
    tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.ams.iam.cfg":
      settings => {
        'iam.service.url' => "http://${tic::services20::iam_service_node}"
      };
    "${config_dir}/org.talend.ipaas.rt.ams.iam.cfg":
      settings => {
        'scim.service.url' => "http://${tic::services20::scim_service_node}"
      }
    }
  }

}
