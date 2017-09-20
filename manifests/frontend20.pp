class tic::frontend20 (

  $scim_service_node = undef,
  $scim_service_url  = undef,

  $client_app_oidc_clientId      = undef,
  $client_app_oidc_clientSecret  = undef,
  $server_app_oidc_clientId      = undef,
  $server_app_oidc_clientSecret  = undef,
  $crypto_service_url            = undef,
  $config_tpsvc_service_url      = undef,
  $logquery_tpsvc_service_url    = undef,

  $iam_oidc_front_url = undef,
  $iam_oidc_back_url = undef,

  $basic_auth_oidc_clientId      = undef,
  $basic_auth_oidc_clientSecret  = undef,

  $workspace_url   = undef,
  $marketplace_url = undef,
  $portal_url      = undef,
  $tdp_url         = undef,
  $tmc_url         = undef,
  $help_url        = undef,

  $tcomp_static_ips = undef,

  $mixpanel_enabled   = undef,
  $mixpanel_ipaas_key = undef,
  $pendo_enabled      = undef,
  $pendo_ipaas_key    = undef,

) {

  contain ::tic::frontend20::params
  contain ::tic::frontend20::config

  Class['::tic::frontend::config'] ->
  Class['::tic::frontend20::params'] ~>
  Class['::tic::frontend20::config'] ~>
  Class['::tic::frontend::service']

}

