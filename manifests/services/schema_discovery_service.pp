class tic::services::schema_discovery_service {

  $config_dir = $tic::services::config::config_dir

  ini_setting {
    'keypair_save':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.keypair.manager.cfg",
      section => '',
      setting => 'keypair.save',
      value   => 'false';
  }

}
