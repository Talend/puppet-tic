class tic::services20 (

  $karaf_features_install = [],
  $iam_service_node       = undef,
  $iam_service_url        = undef,
  $scim_service_node      = undef,
  $scim_service_url       = undef,

) {

  contain ::tic::services20::params
  contain ::tic::services20::config

  Class['::tic::services::config'] ->
  Class['::tic::services20::params'] ~>
  Class['::tic::services20::config'] ~>
  Class['::tic::services::service']

}
