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

  $joined = join_keys_to_values( $settings, $glue )

  tic::ini_setting_wrapper { $joined:
    glue    => $glue,
    path    => $path,
    section => $section,
    ensure  => $ensure
  }
}
