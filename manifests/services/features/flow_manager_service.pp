class tic::services::features::flow_manager_service {

  tic::ini_settings { 'flow_manager':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.flowmanager.cfg",
    settings => {
      'check.code.secret'   => $tic::dts_shared_secret,
      'queue.response.name' => "ipaas.${tic::subenv_prefix}.flowmanager.response.queue",
    }
  }

}
