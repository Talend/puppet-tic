define tic::services::features::install (

  $feature = undef,

) {

  validate_string($feature)

  $feature_class_name = regsubst(delete($feature, 'tipaas-'), '[^0-9a-zA-Z\_]', '_', 'G')

  contain "tic::services::features::${feature_class_name}"

}
