class tic::frontend::service {

  service { 'tomcat-ipaas-srv':
    ensure     => running,
    enable => true,
    hasstatus  => true,
    hasrestart => false,
    start      => 'su -s /bin/bash -c \'CATALINA_HOME=/opt/apache-tomcat CATALINA_BASE=/srv/tomcat/ipaas-srv /opt/apache-tomcat/bin/catalina.sh start\' tomcat',
    stop       => 'su -s /bin/bash -c \'CATALINA_HOME=/opt/apache-tomcat CATALINA_BASE=/srv/tomcat/ipaas-srv /opt/apache-tomcat/bin/catalina.sh stop\' tomcat',
    status     => 'ps aux | grep \'catalina.base=\' | grep -v grep',
    provider   => 'base',
  }

}
