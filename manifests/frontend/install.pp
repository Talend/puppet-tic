class tic::frontend::install {

  require ::tic::frontend::params
  require ::tomcat

  tomcat::install { '/srv/tomcat':
    catalina_home => '/opt/apache-tomcat',
    source_url    => 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24.tar.gz',
  }

  tomcat::setenv::entry { 'JAVA_OPTS':
    catalina_home => '/opt/apache-tomcat',
    quote_char    => '"',
    value         => [
      '$JAVA_OPTS',
      "-Xmx${tic::frontend::params::java_xmx}m",
      "-XX:MaxMetaspaceSize=${tic::frontend::params::java_max_metaspace_size}",
      '-Djava.awt.headless=true',
      '-Dcom.sun.management.jmxremote',
      '-Dcom.sun.management.jmxremote.port=9010',
      '-Dcom.sun.management.jmxremote.local.only=false',
      '-Dcom.sun.management.jmxremote.ssl=false',
      '-Dcom.sun.management.jmxremote.authenticate=false',
      '-verbose:gc',
      '-Xloggc:/srv/tomcat/ipaas-srv/logs/gc.log',
    ]
  }

  if $tic::frontend::params::redis_session_host {
    tomcat::setenv::entry { 'SPRING_REDIS_HOST':
      catalina_home => '/opt/apache-tomcat',
      quote_char    => '"',
      value         => [
        $tic::frontend::params::redis_session_host,
      ]
    }

    tomcat::setenv::entry { 'SPRING_REDIS_PORT':
      catalina_home => '/opt/apache-tomcat',
      quote_char    => '"',
      value         => [
        $tic::frontend::params::redis_session_port,
      ]
    }

    tomcat::setenv::entry { 'SPRING_SESSION_REDIS_NAMESPACE':
      catalina_home => '/opt/apache-tomcat',
      quote_char    => '"',
      value         => [
        $tic::frontend::params::redis_session_namespace,
      ]
    }
  }

  $_config_file = '/opt/apache-tomcat/bin/setenv.sh'
  if ! defined(Concat[$_config_file]) {
    concat { $_config_file:
      owner          => $::tomcat::user,
      group          => $::tomcat::group,
      mode           => '0755',
      ensure_newline => true,
    }
  }
  concat::fragment { 'internal-proxies':
    target  => $_config_file,
    content => template('tic/opt/apache-tomcat/bin/setenv.sh.erb'),
  }

  tomcat::instance { 'ipaas-srv':
    catalina_home  => '/opt/apache-tomcat',
    catalina_base  => '/srv/tomcat/ipaas-srv',
    manage_service => false,
  } ->

  tomcat::config::server::connector { 'ipaas-srv-http':
    catalina_base         => '/srv/tomcat/ipaas-srv',
    port                  => $tic::frontend::params::ipaas_srv_http_port,
    protocol              => 'HTTP/1.1',
    purge_connectors      => true,
    additional_attributes => {
      'address'           => '0.0.0.0',
      'redirectPort'      => '8443',
      'connectionTimeout' => '20000',
    },
  } ->

  tomcat::config::server::connector { 'ipaas-srv-ajp':
    catalina_base         => '/srv/tomcat/ipaas-srv',
    port                  => '8009',
    protocol              => 'AJP/1.3',
    additional_attributes => {
      'address'           => '0.0.0.0',
      'redirectPort'      => '8443',
      'connectionTimeout' => '20000',
    },
  } ->

  tomcat::config::server::valve { 'ipaas-srv-valve':
    catalina_base         => '/srv/tomcat/ipaas-srv',
    class_name            => 'org.apache.catalina.valves.RemoteIpValve',
    additional_attributes => {
      'protocolHeader'  => 'X-Forwarded-Proto',
      'remoteIpHeader'  => 'X-Forwarded-For',
      'internalProxies' => '${server.tomcat.internal-proxies}',
    },
  }

  package {
    'talend-ipaas-web':
      ensure => $tic::frontend::params::version;

    'talend-ipaas-web-admin':
      ensure => absent;

    'talend-ipaas-web-services':
      ensure => $tic::frontend::params::version;

    'talend-ipaas-web-server':
      ensure => $tic::frontend::params::version;

    'talend-ipaas-web-api':
      ensure => $tic::frontend::params::version;

    'talend-ipaas-web-tasks-and-plans-administration':
      ensure => $tic::frontend::params::version;

  } ->
  package { 'talend-ipaas-web-memcache-libs':
      ensure  => '0.2-2', # version with tomcat8 libraries
  }

}
