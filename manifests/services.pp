class tic::services {
  #in case we are in build subenv we don't instantiate the config and service classes
  if $::t_subenv == 'build' {

    contain tic::services::install

  } else {

    contain tic::services::install
    contain tic::services::config
    contain tic::services::service

    Class['tic::services::install'] ->
    Class['tic::services::config'] ->
    Class['tic::services::service']
  }
}
