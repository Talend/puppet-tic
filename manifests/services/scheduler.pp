class tic::services::scheduler {
  $config_dir = $tic::services::config::config_dir

  tic::ini_settings { 'scheduler_quartz':
    path     => "${config_dir}/quartz.properties",
    settings => {
      'org.quartz.dataSource.ipaasDS.dbName'   => $tic::quartz_db_name,
      'org.quartz.dataSource.ipaasDS.port'     => $tic::quartz_db_port,
      'org.quartz.dataSource.ipaasDS.user'     => $tic::quartz_db_user,
      'org.quartz.dataSource.ipaasDS.password' => $tic::quartz_db_password,
      'org.quartz.dataSource.ipaasDS.host'     => $tic::quartz_db_host,
    }
  }

  ini_setting {
    'scheduler_input_queue_name':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.scheduler.core.cfg",
      section => '',
      setting => 'queue.input.name',
      value   => "ipaas.${tic::subenv_prefix}.scheduler.input.queue";
  }
}
