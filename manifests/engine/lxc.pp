class tic::engine::lxc {

  $chroot_cmd = '/usr/sbin/chroot /var/lib/lxc/rt-flow/rootfs'

  # extra packages to install in the lxc container
  $lxc_extra_packages = []

  define extra_package {
    exec {
      "install_${name}":
        command => "${chroot_cmd} /bin/yum  -y install ${name}",
        unless  => "${chroot_cmd} /bin/rpm -q ${name}",
        require => Exec['lxc_create'];
    }
  }

  extra_package { $lxc_extra_packages: }
  package {
    'lxc':
      ensure => installed;
    'lxc-templates':
      ensure => installed;
    'libvirt':
      ensure  => installed,
      require => Package['rsyslog'];
    'rsyslog':
        #ensure => '7.4.7-7.el7_0'
        ensure => 'installed'
  }

  service {
    'libvirtd':
      enable  => true,
      require => [Package['libvirt'], Package['lxc']];

    'lxc':
      enable => false
  }

  exec {
    'lxc_create':
      command => '/usr/bin/lxc-create -n rt-flow -t /usr/share/lxc/templates/lxc-centos',
      creates => '/var/lib/lxc/rt-flow',
      require => [Package['lxc'], Package['lxc-templates']];

    "${chroot_cmd} /usr/sbin/groupadd -g 199 -r ipaasgrp":
      unless  => "${chroot_cmd} /usr/bin/getent group ipaasgrp",
      require => Exec['lxc_create'];

    "${chroot_cmd} /usr/sbin/useradd -r -d /opt/talend/ipaas -s /sbin/nologin -g ipaasgrp -u 199 ipaassrv":
      unless  => "${chroot_cmd} /usr/bin/getent passwd ipaassrv",
      require => Exec["${chroot_cmd} /usr/sbin/groupadd -g 199 -r ipaasgrp"];

    'copy_java_home':
      command => "/bin/cp --parents -a ${tic::engine::params::java_home} /var/lib/lxc/rt-flow/rootfs",
      creates => "/var/lib/lxc/rt-flow/rootfs/${tic::engine::params::java_home}",
      require => Exec['lxc_create'];
  }

  $karaf_conf_properties_base = {
    'wrapper.jvm_kill.delay'     => 5,
    'wrapper.java.maxmemory'     => $tic::engine::params::java_xmx,
    'wrapper.disable_restarts'   => $tic::engine::params::wrapper_diable_restarts,
    'wrapper.java.additional.10' => '-XX:MaxPermSize=256m',
    'wrapper.java.additional.11' => "-XX:OnOutOfMemoryError=${tic::engine::params::karaf_base_path}/scripts/oomkiller4j.sh",
  }

  if $tic::engine::params::jmx_enabled {
    $karaf_conf_properties = merge( $karaf_conf_properties_base, {
      'wrapper.java.additional.12' => '-Dcom.sun.management.jmxremote.port=7199',
      'wrapper.java.additional.13' => '-Dcom.sun.management.jmxremote.authenticate=false',
      'wrapper.java.additional.14' => '-Dcom.sun.management.jmxremote.ssl=false'
    } )
  } else {
    $karaf_conf_properties = $karaf_conf_properties_base
  }

  tic::engine::params::karaf_service_install { 'rt-flow-service-lxc':
    java_home       => $tic::engine::params::java_home,
    karaf_base      => $tic::engine::params::karaf_base_path,
    owner           => 'ipaassrv',
    conf_properties => $karaf_conf_properties
  }

  file {
    '/var/lib/lxc/rt-flow/rootfs/opt/talend':
      ensure  => directory,
      require => Exec['lxc_create'];

    '/usr/share/lxc/config/centos.common.conf':
      source  => 'puppet:///modules/tic/usr/share/lxc/config/centos.common.conf',
      require => Exec['lxc_create'];

    '/var/lib/lxc/rt-flow/tmp_root_pass':
      ensure  => absent,
      require => Exec['lxc_create'];

    '/var/lib/lxc/rt-flow/rootfs/etc/localtime':
      source  => '/usr/share/zoneinfo/UTC',
      require => Exec['lxc_create'];

    '/var/lib/lxc/rt-flow/rootfs/etc/sysconfig/clock':
      source  => '/etc/sysconfig/clock',
      require => Exec['lxc_create'];

    '/var/lib/lxc/rt-flow/rootfs/etc/sysconfig/network-scripts/ifcfg-eth0':
      content => template('tic/var/lib/lxc/rt-flow/rootfs/etc/sysconfig/network-scripts/ifcfg-eth0.erb'),
      require => Exec['lxc_create'];

    '/var/lib/lxc/rt-flow/rootfs/etc/hosts':
      content => template('tic/var/lib/lxc/rt-flow/rootfs/etc/hosts.erb'),
      require => Exec['lxc_create'];

    '/var/lib/lxc/rt-flow/rootfs/etc/locale.conf':
      content => 'LANG="en_US.UTF-8"',
      require => Exec['lxc_create'];

    '/var/lib/lxc/rt-flow/rootfs/etc/sysconfig/i18n':
      content => 'LANG="en_US.UTF-8"',
      require => Exec['lxc_create'];
  }

  ini_setting {

    'lxc_start_on_boot':
      ensure  => present,
      path    => '/var/lib/lxc/rt-flow/config',
      section => '',
      setting => 'lxc.start.auto',
      value   => '1',
      require => Exec['lxc_create'];

    'disable_kmesg':
      ensure  => present,
      path    => '/var/lib/lxc/rt-flow/config',
      section => '',
      setting => 'lxc.kmsg',
      value   => '0',
      require => Exec['lxc_create'];

  }

  # file_line is used instead of ini_setting because of duplicate setting
  file_line {
    'lxc_mount_temp':
      line    => 'lxc.mount.entry = /mnt/ephemeral0 tmp none rw,bind 0 0',
      path    => '/var/lib/lxc/rt-flow/config',
      require => [Exec['lxc_create'], File['/mnt/ephemeral0']];

    'lxc_mount_tipaas':
      path    => '/var/lib/lxc/rt-flow/config',
      line    => 'lxc.mount.entry = /opt/talend opt/talend none rw,bind 0 0',
      require => Exec['lxc_create'];
  }

}
