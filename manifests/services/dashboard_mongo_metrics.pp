class tic::services::dashboard_mongo_metrics(
  $api_key = $datadog::agent::api_key
) inherits datadog_agent::params {


  if ! defined(Package['python-pip']) {
    package { 'python-pip':
      ensure          => installed,
      install_options => '--enablerepo=dist-epel';
    }
  }
  if ! defined(Package['datadog']) {
    package{ 'datadog':
      ensure   => installed,
      provider => 'pip',
      require  => Package['python-pip'];
    }
  }
  if ! defined(Package['pymongo']) {
    package{ 'pymongo':
      ensure   => installed,
      provider => 'pip',
      require  => Package['python-pip'];
    }
  }

  file { '/usr/local/bin/dashboard_mongo_metrics.py':
    ensure  => file,
    owner   => $datadog_agent::params::dd_user,
    group   => $datadog_agent::params::dd_group,
    mode    => '0755',
    content => template('tipaas/usr/local/bin/dashboard_mongo_metrics.py.erb'),
    require => Package[$datadog_agent::params::package_name],
    notify  => Service[$datadog_agent::params::service_name]
  }

  cron { 'dashboard_mongo_stats':
    ensure  => present,
    command => '/usr/bin/flock -n /var/run/dashboard_mongo_metrics.lock  /usr/local/bin/dashboard_mongo_metrics.py 2>&1',
    hour    => '0',
    minute  =>  '0'
  }

}
