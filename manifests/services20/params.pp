class tic::services20::params {

  $karaf_features_install = pick($tic::services20::karaf_features_install, [])

  $iam_service_node       = pick($tic::services20::iam_service_node, 'localhost')
  $scim_service_node      = pick($tic::services20::scim_service_node, 'localhost')
  $crypto_service         = pick($tic::services20::crypto_service_node, 'localhost')

  $iam_service_url        = pick($tic::services20::iam_service_url, "http://${iam_service_node}")
  $scim_service_url       = pick($tic::services20::scim_service_url, "http://${scim_service_node}")
  $crypto_service_url     = pick($tic::services20::crypto_service_url, "http://${crypto_service_node}")

}
