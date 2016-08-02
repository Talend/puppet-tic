class tic::engine (


) {

  contain tic::engine::install
  contain tic::engine::storage

  # in case we are in build subenv we don't instantiate the config and service classes
  if $::t_subenv == 'build' {
    contain tic::engine::lxc
  } else {
    contain tic::engine::config
    contain tic::engine::lxc_dns
    contain tic::engine::service
  }

}
