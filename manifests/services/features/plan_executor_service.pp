class tic::services::features::plan_executor_service {

  $redis_host = $tic::services::params::dispatcher_redis_host # using same redis host as for dispatcher [DEVOPS-10131]

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.pe.datasource.cfg":
    settings => {
      'datasource.servername' => $tic::services::params::pe_db_host,
      'datasource.password'   => $tic::services::params::pe_db_password,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.pe.service.cfg":
    settings => {
      'db.host' => $redis_host
    }
  }

}
