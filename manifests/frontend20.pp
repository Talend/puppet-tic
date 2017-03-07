class tic::frontend20 (

  $scim_service_node = undef,

) {

  contain ::tic::frontend20::config

  Class['::tic::frontend::config'] ->
  Class['::tic::frontend20::config'] ~>
  Class['::tic::frontend::service']

}

