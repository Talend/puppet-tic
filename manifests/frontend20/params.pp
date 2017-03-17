class tic::frontend20::params {

  
  $scim_service_node = pick($tic::frontend20::scim_service_node, 'localhost')
  $scim_service_url  = pick($tic::frontend20::scim_service_url, "http://${scim_service_node}")

}
