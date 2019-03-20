class tic::services::init_configuration_service (

  $username    = undef,
  $password    = undef,
  $ensure_init = true,

) {

  $ami_id             = $tic::services::params::rt_flow_ami_id
  $security_groups    = $tic::services::params::rt_flow_security_groups
  $instance_type      = $tic::services::params::rt_flow_instance_type
  $subnet_id          = $tic::services::params::rt_flow_subnet_id
  $instance_profile   = $tic::services::params::rt_flow_instance_profile
  $config_service_url = $tic::services::params::config_service_url

  $rt_aws_region    = $tic::services::params::rt_aws_region
  $t_branch         = pick($tic::services::params::rt_flow_t_branch, 'trunk')

  $failover_subnets_ids = pick($tic::services::params::rt_flow_failover_subnets_ids, '')

  $accountId = 'NODEMAN_CONFIG'
  $applicationId = 'tipaas'

  $init_configuration_service_cmd = "/bin/bash -c 'code=\$(/usr/bin/curl -s -o /dev/null -w \"%{http_code}\" \
  -X POST \
  -d @/var/tmp/init_configuration_service.json \
  -H \"Content-Type: application/json\" \
  ${config_service_url}/v1/configurations/accounts/${accountId}/applications/${applicationId}); \
  if [ \$code = 409 ]; then \
  /usr/bin/curl --fail \
  -X PUT \
  -d @/var/tmp/init_configuration_service.json \
  -H \"Content-Type: application/json\" \
  ${config_service_url}/v1/configurations/accounts/${accountId}/applications/${applicationId}; fi'"

  if $ensure_init and $ami_id != '' {
    file { '/var/tmp/init_configuration_service.json':
      content => template('tic/var/tmp/init_configuration_service.json.erb'),
    } ->
    exec { 'init configuration-service':
      command   => $init_configuration_service_cmd,
      tries     => 30,
      try_sleep => 30,
      returns   => [0, 22], # TODO
      unless    => "/usr/bin/curl --silent ${config_service_url}/v1/configurations/accounts/${accountId}/applications/${applicationId}/property/nodeman_ami_version_1_3?decrypt=false | grep '\"${ami_id}\"'"
    }
  }

}
