class tic::services::service {
  tic::karaf_service_install { 'rt-infra-service':
    java_home       => $tic::java_home,
    karaf_base      => $tic::karaf_base_path,
    owner           => 'ipaassrv',
    conf_properties => {
      'wrapper.jvm_kill.delay'     => 5,
      'wrapper.java.additional.10' => '-XX:MaxPermSize=256m',
      'wrapper.java.additional.11' => '-Dcom.sun.management.jmxremote.port=7199',
      'wrapper.java.additional.12' => '-Dcom.sun.management.jmxremote.authenticate=false',
      'wrapper.java.additional.13' => '-Dcom.sun.management.jmxremote.ssl=false',
      'wrapper.java.maxmemory'     => $tic::java_xmx,
      'wrapper.disable_restarts'   => $tic::wrapper_diable_restarts,
    }
  }
}

