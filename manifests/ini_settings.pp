define tic::ini_settings (

  $path     = undef,
  $settings = {},
  $section  = '',
  $ensure   = present,
  $glue     = '{{{'

) {
  validate_string($path)
  validate_hash($settings)
  validate_string($section)
  validate_string($glue)

  $_settings = prefix($settings, "${path}:")

  $joined = join_keys_to_values( $_settings, $glue )

  tic::ini_setting_wrapper { $joined:
    glue    => $glue,
    path    => $path,
    section => $section,
    ensure  => $ensure
  }
}
