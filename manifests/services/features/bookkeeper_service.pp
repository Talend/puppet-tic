class tic::services::features::bookkeeper_service {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  ini_setting { 'zookeeper_prefix':
    ensure  => present,
    path    => "${config_dir}/org.talend.ipaas.rt.bookkeeper.zk.backend.cfg",
    section => '',
    setting => 'zk.path',
    value   => $tic::services::params::zookeeper_prefix;
  }

  if $tic::services::params::zookeeper_nodes_count >= $tic::services::params::min_zookeeper_nodes {
    ini_setting { 'zookeeper_connection':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.bookkeeper.zk.backend.cfg",
      section => '',
      setting => 'zk.endpoints',
      value   => $tic::services::params::zookeeper_connection;
    }
  } else {
    warning("got ${tic::services::params::zookeeper_nodes_count} zookeeper nodes, expected ${tic::services::params::min_zookeeper_nodes}")
  }

}
