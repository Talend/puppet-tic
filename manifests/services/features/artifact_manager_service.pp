class tic::services::features::artifact_manager_service {
  tic::ini_settings { 'artifact_manager_service':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.am.service.cfg",
    settings => {
      'nexus_urls'        => $tic::nexus_url,
      'nexus_password'    => $tic::nexus_password,
      'min.success.count' => $tic::nexus_min_host_count,
    }
  }
}
