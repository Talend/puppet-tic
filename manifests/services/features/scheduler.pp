class tic::services::features::scheduler {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { 'scheduler_quartz':
    path     => "${config_dir}/quartz.properties",
    settings => {
      'org.quartz.dataSource.ipaasDS.dbName'   => $tic::services::params::quartz_db_name,
      'org.quartz.dataSource.ipaasDS.port'     => $tic::services::params::quartz_db_port,
      'org.quartz.dataSource.ipaasDS.user'     => $tic::services::params::quartz_db_user,
      'org.quartz.dataSource.ipaasDS.password' => $tic::services::params::quartz_db_password,
      'org.quartz.dataSource.ipaasDS.host'     => $tic::services::params::quartz_db_host,
    }
  }

  ini_setting { 'scheduler_input_queue_name':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.scheduler.core.cfg",
      section => '',
      setting => 'queue.input.name',
      value   => "ipaas.${tic::services::params::subenv_prefix}.scheduler.input.queue";
  }

}
