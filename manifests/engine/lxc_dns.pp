class tic::engine::lxc_dns {

  file {
    '/var/lib/lxc/rt-flow/rootfs/etc/sysconfig/network-scripts/ifcfg-eth0':
      content => template('tic/var/lib/lxc/rt-flow/rootfs/etc/sysconfig/network-scripts/ifcfg-eth0.erb');

    '/var/lib/lxc/rt-flow/rootfs/etc/hosts':
      content => template('tic/var/lib/lxc/rt-flow/rootfs/etc/hosts.erb');
  }

}
