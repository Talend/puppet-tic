# installs and configures engine instances
class tic::engine {

  #in case we are in build subenv we don't instantiate the config and service classes
  if $::t_subenv == 'build' {
    contain tic::engine::install
    contain tic::engine::storage
    contain tic::engine::lxc
  } else {
    contain tic::engine::install
    contain tic::engine::config
    contain tic::engine::storage
    contain tic::engine::lxc_dns
    contain tic::engine::service

    Class['tic::engine::install'] ->
    Class['tic::engine::config'] ->
    Class['tic::engine::storage'] ->
    Class['tic::engine::lxc_dns'] ->
    Class['tic::engine::service']
  }

}
