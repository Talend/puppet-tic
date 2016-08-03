define tic::services::features::install {

  validate_string($name)

  $feature = regsubst(delete($name, 'tipaas-'), '[^0-9a-zA-Z\_]', '_', 'G')

  if defined("tic::services::features::${feature}") {
    contain "tic::services::features::${feature}"
  }

}
