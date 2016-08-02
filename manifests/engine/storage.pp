class tic::engine::storage {

  require ::tic::engine::install

  file {
    '/mnt/ephemeral0':
      ensure => directory,
      mode   => '1777'
  }

  cron {
    'cleanup-flow-temp':
      ensure   => present,
      user     => 'root',
      command  => '/usr/sbin/tmpwatch -s 1 /mnt/ephemeral0',
      minute   => '*/10',
      hour     => '*',
      month    => '*',
      monthday => '*',
      weekday  => '*'
  }

  $blockdevices_list = split($::blockdevices, ',')

  if member($blockdevices_list, 'xvdb') {
    filesystem { '/dev/xvdb':
      ensure  => present,
      fs_type => 'ext3';
    } ->
    mount { '/mnt/ephemeral0':
      ensure  => 'mounted',
      device  => '/dev/xvdb',
      fstype  => 'ext3',
      options => 'defaults,nodev,nosuid,noexec',
      atboot  => true,
      require => File['/mnt/ephemeral0'],
      notify  => Exec['fix_mount_permission'];
    }

    exec { 'fix_mount_permission':
      command     => '/bin/chmod 1777 /mnt/ephemeral0',
      refreshonly => true;
    }
  }

}
