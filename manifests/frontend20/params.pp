class tic::frontend20::params {

  $scim_service_node = pick($tic::frontend20::scim_service_node, 'localhost')
  $scim_service_url  = pick($tic::frontend20::scim_service_url, "http://${scim_service_node}")

  $iam_oidc_front_url  = pick($tic::frontend20::iam_oidc_front_url, "http://${scim_service_node}")
  $iam_oidc_back_url  = pick($tic::frontend20::iam_oidc_back_url, "http://${scim_service_node}")

  $client_app_oidc_clientId      = pick($tic::frontend20::client_app_oidc_clientId,     'unconfigured')
  $client_app_oidc_clientSecret  = pick($tic::frontend20::client_app_oidc_clientSecret, 'unconfigured')
  $server_app_oidc_clientId      = pick($tic::frontend20::server_app_oidc_clientId,     'unconfigured')
  $server_app_oidc_clientSecret  = pick($tic::frontend20::server_app_oidc_clientSecret, 'unconfigured')
  $crypto_service_url            = pick($tic::frontend20::crypto_service_url, "http://${crypto_service_node}")

}
