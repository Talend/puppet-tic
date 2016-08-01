class tic::services::install {

  require ::tic::services::params

  if $tic::services::params::manage_packages {
    package { 'talend-ipaas-rt-infra':
      ensure => $tic::services::params::version
    }
  }

}
