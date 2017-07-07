class tic::frontend18 (

  $workspace_url   = undef,
  $marketplace_url = undef,
  $help_url        = undef,

) {

  contain ::tic::frontend18::params
  contain ::tic::frontend18::config

  Class['::tic::frontend::config'] ->
  Class['::tic::frontend18::params'] ~>
  Class['::tic::frontend18::config'] ~>
  Class['::tic::frontend::service']

}

