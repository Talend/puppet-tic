class tic::services::features::schema_discovery_service_core {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  ini_setting { 'keypair_save':
    ensure  => present,
    path    => "${config_dir}/org.talend.ipaas.rt.keypair.manager.cfg",
    section => '',
    setting => 'keypair.save',
    value   => false;
  }

}
