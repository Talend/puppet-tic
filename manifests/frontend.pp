#this is the main class for the frontend role
class tic::frontend {

  contain tic::frontend::install
  contain tic::frontend::config
  contain tic::frontend::service

  Class['tic::frontend::install'] ->
  Class['tic::frontend::config'] ->
  Class['tic::frontend::service']

}
