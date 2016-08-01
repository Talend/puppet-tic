class tic::services::install {

  if $tic::services::params::manage_packages {
    package { 'talend-ipaas-rt-infra':
      ensure => $tic::services::params::version
    }
  }

}
