define tic::ini_settings (

  $path     = undef,
  $settings = {},
  $section  = '',
  $ensure   = present,
  $glue     = '{{{'

) {

  $real_path = pick($path, $name)

  validate_string($real_path)
  validate_hash($settings)
  validate_string($section)
  validate_string($glue)

  $_settings = prefix($settings, "${real_path}:")

  $joined = join_keys_to_values( $_settings, $glue )

  tic::ini_setting_wrapper { $joined:
    ensure  => $ensure,
    glue    => $glue,
    path    => $real_path,
    section => $section,
  }

}
