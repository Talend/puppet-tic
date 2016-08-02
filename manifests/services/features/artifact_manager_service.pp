class tic::services::features::artifact_manager_service {

  tic::ini_settings { "${tic::services::params::karaf_base_path}/etc/org.talend.ipaas.rt.am.service.cfg":
    settings => {
      'nexus_urls'        => $tic::services::params::nexus_urls,
      'nexus_password'    => $tic::services::params::nexus_password,
      'min.success.count' => $tic::services::params::nexus_min_host_count,
    }
  }

}
