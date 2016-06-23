#this is a private class that installs the flow runtime
class tic::services::install {
  if $tic::manage_packages {
    package { 'talend-ipaas-rt-infra':
      ensure => $tic::version
    }
  }
}
