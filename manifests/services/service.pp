class tic::services::service {

  require ::tic::services::config

  tic::karaf_service_install { 'rt-infra-service':
    service_ensure  => $tic::services::params::karaf_service_ensure,
    service_enable  => $tic::services::params::karaf_service_enable,
    java_home       => $tic::services::params::java_home,
    karaf_base      => $tic::services::params::karaf_base_path,
    owner           => 'ipaassrv',
    conf_properties => {
      'wrapper.jvm_kill.delay'     => 5,
      'wrapper.java.additional.10' => '-XX:MaxPermSize=256m',
      'wrapper.java.additional.11' => '-Dcom.sun.management.jmxremote.port=7199',
      'wrapper.java.additional.12' => '-Dcom.sun.management.jmxremote.authenticate=false',
      'wrapper.java.additional.13' => '-Dcom.sun.management.jmxremote.ssl=false',
      'wrapper.java.maxmemory'     => $tic::services::params::java_xmx,
      'wrapper.disable_restarts'   => $tic::services::params::wrapper_diable_restarts,
    }
  }

}
