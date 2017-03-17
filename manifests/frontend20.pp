class tic::frontend20 (

  $scim_service_node = undef,
  $scim_service_url  = undef,

) {

  contain ::tic::frontend20::params
  contain ::tic::frontend20::config

  Class['::tic::frontend::config'] ->
  Class['::tic::frontend20::params'] ~>
  Class['::tic::frontend20::config'] ~>
  Class['::tic::frontend::service']

}

