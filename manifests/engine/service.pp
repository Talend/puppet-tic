# init service definition for rt flow
class tic::engine::service {

  if $tic::rt_flow_lxc_enable {
    firewall {
      '000 block metadata from the lxc':
        destination => '169.254.169.254/32',
        action      => 'drop',
        chain       => 'FORWARD';

      '999 block access from the lxc to the host':
        destination => '192.168.122.0/24',
        action      => 'drop',
        chain       => 'INPUT'
    }
  } else {
    $karaf_conf_properties_base = {
      'wrapper.jvm_kill.delay'     => 5,
      'wrapper.java.maxmemory'     => $tic::java_xmx,
      'wrapper.disable_restarts'   => $tic::wrapper_diable_restarts,
      'wrapper.java.additional.10' => '-XX:MaxPermSize=256m',
      'wrapper.java.additional.11' => "-XX:OnOutOfMemoryError=${tic::karaf_base_path}/scripts/oomkiller4j.sh",
    }

    if $tic::jmx_enabled {
      $karaf_conf_properties = merge( $karaf_conf_properties_base, {
        'wrapper.java.additional.12' => '-Dcom.sun.management.jmxremote.port=7199',
        'wrapper.java.additional.13' => '-Dcom.sun.management.jmxremote.authenticate=false',
        'wrapper.java.additional.14' => '-Dcom.sun.management.jmxremote.ssl=false'
      } )
    } else {
      $karaf_conf_properties = $karaf_conf_properties_base
    }

    tic::karaf_service_install { 'rt-flow-service':
      java_home       => $tic::java_home,
      karaf_base      => $tic::karaf_base_path,
      owner           => 'ipaassrv',
      conf_properties => $karaf_conf_properties
    }
  }

  if $tic::rt_flow_purge_puppet {
  #uninstall puppet modules after rt-flow karaf has been started
    file {
      '/etc/puppet/secure':
        ensure  => absent,
        recurse => true,
        force   => true,
        require => Service['rt-flow-service']
    }

    package {

      'talend-puppet-modules-site-trunk':
        ensure  => absent,
        require => Service['rt-flow-service'];

      'talend-puppet-modules-dist-trunk':
        ensure  => absent,
        require => Service['rt-flow-service'];

      'talend-puppet-manifests-trunk':
        ensure  => absent,
        require => Service['rt-flow-service'];

      'talend-hiera-data-trunk':
        ensure  => absent,
        require => Service['rt-flow-service'];
    }

  }

}

