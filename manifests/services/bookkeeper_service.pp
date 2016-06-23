class tic::services::bookkeeper_service {

  $zookeeper_prefix = "/subenv/${tic::subenv_prefix}/role/bookkeeper"

  $config_dir = $tic::services::config::config_dir

  ini_setting { 'zookeeper_prefix':
    ensure  => present,
    path    => "${config_dir}/org.talend.ipaas.rt.bookkeeper.zk.backend.cfg",
    section => '',
    setting => 'zk.path',
    value   => $zookeeper_prefix;
  }

  if $tic::zookeeper_nodes_count >= $tic::min_zookeeper_nodes {
    ini_setting { 'zookeeper_connection':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.bookkeeper.zk.backend.cfg",
      section => '',
      setting => 'zk.endpoints',
      value   => $tic::zookeeper_connection;
    }
  } else {
    warning("got ${tic::zookeeper_nodes_count} activemq nodes, expected ${tic::min_zookeeper_nodes}")
  }
}

