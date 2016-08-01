require 'spec_helper'

describe 'TIC Frontend' do

  context 'When TIC Frontend installed' do
    describe 'Tomcat Server Info' do
      subject { command('/usr/bin/java -cp /opt/apache-tomcat/lib/catalina.jar org.apache.catalina.util.ServerInfo') }
      its(:stdout) { should include 'Apache Tomcat/8.0.33' }
    end

    describe 'Tomcat Environment Java Options' do
      subject { file('/opt/apache-tomcat/bin/setenv.sh').content }
      it { should include '-XX:MaxPermSize=256m' }
      it { should include '-Djava.security.auth.login.config=$CATALINA_BASE/conf/jaas-ipaas-services.conf' }
      it { should include '-Djava.awt.headless=true' }
      it { should include '-Xmx1024m' }
    end

    describe 'Ipaas Tomcat Instance' do
      subject { file('/srv/tomcat/ipaas-srv') }
      it { should exist }
    end

    describe 'Ipaas Tomcat Instance root folder' do
      subject { file('/srv/tomcat/ipaas-srv/webapps/ROOT') }
      it { should be_symlink }
      it { should be_linked_to '/srv/tomcat/ipaas-srv/webapps/ipaas' }
    end

    describe 'Tomcat Connector Configuration : ipaas-srv-ajp' do
      subject { file('/srv/tomcat/ipaas-srv/conf/server.xml').content }
      it { should include 'port="8009"' }
      it { should include 'address="0.0.0.0"' }
      it { should include 'protocol="AJP/1.3"' }
      it { should include 'connectionTimeout="20000"' }
      it { should include 'redirectPort="8443"' }
    end

    describe 'Tomcat Connector Configuration : ipaas-srv-http' do
      subject { file('/srv/tomcat/ipaas-srv/conf/server.xml').content }
      it { should include 'port="8081"' }
      it { should include 'address="0.0.0.0"' }
      it { should include 'protocol="HTTP/1.1"' }
      it { should include 'connectionTimeout="20000"' }
      it { should include 'redirectPort="8443"' }
    end

    %w(talend-ipaas-web talend-ipaas-web-server talend-ipaas-web-services).each do |p|
      describe package(p) do
        it { should be_installed }
      end
    end

    describe package('talend-ipaas-web-admin') do
      it { should_not be_installed }
    end
  end

  context 'When TIC Frontend configured' do
    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js') do
      its(:content) { should include 'BASE_URL : \'/ipaas-server/services\',' }
      its(:content) { should include 'EXCHANGE_URL : \'https://exchange.talend.com\',' }
    end

    %w(
      /srv/tomcat/ipaas-srv/conf/jaas-ipaas-services.conf
      /srv/tomcat/ipaas-srv/conf/jaas-ipaas-server.conf
    ).each do |f|
      describe file(f) do
        its(:content) { should include 'wsdl.location="http://missing:8080/sts/SecurityTokenService/UT?wsdl"' }
        its(:content) { should include 'ws-security.username="tadmin"' }
        its(:content) { should include 'ws-security.password="missing";' }
      end
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas-server/META-INF/context.xml') do
      its(:content) { should include 'memcachedNodes="some_elasticache_address"' }
    end

    %w(
    /srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js
    /srv/tomcat/ipaas-srv/conf/jaas-ipaas-services.conf
    /srv/tomcat/ipaas-srv/conf/jaas-ipaas-server.conf
    /srv/tomcat/ipaas-srv/webapps/ipaas-server/META-INF/context.xml
    ).each do |f|
      describe file(f) do
        it { should be_file }
      end
    end

    %w(
    talend-ipaas-web
    talend-ipaas-web-services
    talend-ipaas-web-server
    talend-ipaas-web-memcache-libs).each do |p|
      describe package(p) do
        it { should be_installed }
      end
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/web.xml') do
      its(:content) { should include '<secure>true</secure>' }
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/web.xml') do
      its(:content) { should include '<welcome-file>index-min.jsp</welcome-file>' }
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties') do
      its(:content) { should include 'container_management_url=http://testcmsnode:8181/services/container-management-service' }
      its(:content) { should include 'flow_manager_url=http://flow_manager_url' }
      its(:content) { should_not include 'flow_manager_node' }
    end
  end

  context 'When TIC Frontend running' do
    describe port(8081) do
      it { should be_listening.on('0.0.0.0') }
    end

    describe command('/usr/bin/wget -O - http://127.0.0.1:8081') do
      its(:stdout) { should include '<title>Talend Integration Cloud</title>' }
    end

    describe port(8009) do
      it { should be_listening }
    end

    describe port(8005) do
      it { should be_listening }
    end

    describe command('/usr/bin/ps ax | grep java') do
      its(:stdout) { should include '-Djava.security.auth.login.config=/srv/tomcat/ipaas-srv/conf/jaas-ipaas-services.conf' }
      its(:stdout) { should include '-Djava.awt.headless=true' }
      its(:stdout) { should include '-Xmx1024m' }
      its(:stdout) { should include '-XX:MaxPermSize=256m' }
      its(:stdout) { should include '-Djava.io.tmpdir=/srv/tomcat/ipaas-srv/temp' }
    end

    describe service('tomcat-ipaas-srv') do
      it { should be_enabled }
      it { should be_running }
    end
  end

end
