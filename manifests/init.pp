#this is the ipaas main class.
#variables are initialized in tic::globals -> tic::params -> tic
class tic($jmx_enabled=false) inherits tic::params {

  contain tic::common

  case $role {
    'engine' : { # tic::runtime_engine
      contain tic::engine
      Class['tic::common'] -> Class['tic::engine']
    }
    'services': { # tic::services
      contain tic::services
      Class['tic::common'] -> Class['tic::services']
    }
    'frontend': { # tic::frontend
      contain tic::frontend
      Class['tic::common'] -> Class['tic::frontend']
    }
    'base': {
      contain tic::base
      Class['tic::common'] -> Class['tic::base']
    }
    default : {
      fail("unsupported tic::role: ${role}")
    }
  }
}

