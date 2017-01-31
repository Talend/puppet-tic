class tic::services20(
  $karaf_features_install = [],
  $iam_service_node = undef,
  $scim_service_node = undef
) {

  contain ::tic::services20::config

  Class['::tic::services::config'] ->
  Class['::tic::services20::config'] ~>
  Class['::tic::services::service']

}
