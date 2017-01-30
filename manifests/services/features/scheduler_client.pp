class tic::services::features::scheduler_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  ini_setting { 'scheduler_client_input_queue_name':
    ensure  => present,
    path    => "${config_dir}/org.talend.ipaas.rt.scheduler.client.cfg",
    section => '',
    setting => 'scheduler.input.queue.name',
    value   => "ipaas.talend.scheduler.input.queue";
  }

}
