class tic::services::features::flow_manager_service {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.flowmanager.cfg":
    settings => {
      'check.code.secret'   => $tic::services::params::dts_shared_secret,
      'queue.response.name' => 'ipaas.talend.flowmanager.response.queue',
    }
  }

}
