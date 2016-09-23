class tic::services::init_configuration_service (

  $username = undef,
  $password = undef,
  $ensure_init = true,

) {

  $ami_id           = $tic::services::params::rt_flow_ami_id
  $security_groups  = $tic::services::params::rt_flow_security_groups
  $instance_type    = $tic::services::params::rt_flow_instance_type
  $subnet_id        = $tic::services::params::rt_flow_subnet_id
  $instance_profile = $tic::services::params::rt_flow_instance_profile

  $service_auth = "-u ${username}:${password}"

  $init_configuration_service_cmd = "/usr/bin/curl --fail \
  -X PUT \
  -d @/var/tmp/init_configuration_service.json \
  -H 'Content-Type: application/json' \
  ${service_auth} \
  http://localhost:8181/services/configuration-service/default"

  if $ensure_init {
    file { '/var/tmp/init_configuration_service.json':
      content => template('tic/var/tmp/init_configuration_service.json.erb'),
    } ->
    exec { 'init configuration-service':
      command   => $init_configuration_service_cmd,
      tries     => 30,
      try_sleep => 30,
      returns   => [0, 22], # TODO
      unless    => "/usr/bin/curl http://localhost:8181/services/configuration-service/default?p=nodeman.ami.version_1_3 ${service_auth} | grep ${ami_id}"
    }
  }

}
