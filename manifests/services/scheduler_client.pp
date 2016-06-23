class tic::services::scheduler_client {

  $config_dir = $tic::services::config::config_dir

  ini_setting {
    'scheduler_client_input_queue_name':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.scheduler.client.cfg",
      section => '',
      setting => 'scheduler.input.queue.name',
      value   => "ipaas.${tic::subenv_prefix}.scheduler.input.queue";
  }

}
