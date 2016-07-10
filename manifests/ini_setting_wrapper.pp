define tic::ini_setting_wrapper (

  $glue    = undef,
  $path    = undef,
  $section = '',
  $ensure  = present,

) {

  validate_string($glue)
  validate_string($path)

  $settings = split( $name, $glue )

  $key   = $settings[0]
  $value = $settings[1]

  $_key = split( $key, "${path}:")
  $real_key = $_key[1]

  validate_string($key)
  validate_string($value)

  ini_setting { "${path}-${section}-${key}-${value}":
      ensure  => $ensure,
      path    => $path,
      section => $section,
      setting => $real_key,
      value   => $value
  }
}

