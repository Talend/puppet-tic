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

  $config_tpsvc_service_url      = pick($tic::frontend20::config_tpsvc_service_url, 'unconfigured')
  $logquery_tpsvc_service_url    = pick($tic::frontend20::logquery_tpsvc_service_url, 'unconfigured')

  $basic_auth_oidc_clientId      = pick($tic::frontend20::basic_auth_oidc_clientId, 'unconfigured')
  $basic_auth_oidc_clientSecret  = pick($tic::frontend20::basic_auth_oidc_clientSecret, 'unconfigured')

  $workspace_url   = pick($tic::frontend20::workspace_url,   '/ipaas-server/services')
  $marketplace_url = pick($tic::frontend20::marketplace_url, 'https://exchange.talend.com')
  $portal_url      = pick($tic::frontend20::portal_url,      'unconfigured')
  $tdp_url         = pick($tic::frontend20::tdp_url,         'unconfigured')
  $tmc_url         = pick($tic::frontend20::tmc_url,         'unconfigured')
  $help_url        = pick($tic::frontend20::help_url,        'https://help.talend.com/search/all?filters=EnrichPlatform~%2522Talend+Integration+Cloud%2522_%2522Talend+Studio%2522*EnrichVersion~%2522Cloud%2522&content-lang=en')

  $tcomp_static_ips = pick($tic::frontend20::tcomp_static_ips, '')

  $mixpanel_enabled   = pick($tic::frontend20::mixpanel_enabled,   false)
  $mixpanel_ipaas_key = pick($tic::frontend20::mixpanel_ipaas_key, 'unconfigured')
  $pendo_enabled      = pick($tic::frontend20::pendo_enabled,      false)
  $pendo_ipaas_key    = pick($tic::frontend20::pendo_ipaas_key,    'unconfigured')
}
