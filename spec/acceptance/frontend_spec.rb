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
      it { should include '-Djava.awt.headless=true' }
      it { should include '-Xmx1024m' }
      it { should include 'SPRING_REDIS_HOST="redis-host"' }
      it { should include 'SPRING_REDIS_PORT="8888"' }
      it { should include 'SPRING_SESSION_REDIS_NAMESPACE="redis-namespace"' }
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

    %w(
    talend-ipaas-web
    talend-ipaas-web-services
    talend-ipaas-web-server
    talend-ipaas-web-memcache-libs).each do |p|
      describe package(p) do
        it { should be_installed }
      end
    end

    describe package('talend-ipaas-web-admin') do
      it { should_not be_installed }
    end
  end

  context 'When TIC Frontend configured' do
    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/conf/application-context.xml') do
      it { should be_file }
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js') do
      its(:content) { should include 'BASE_URL : \'123456\',' }
      its(:content) { should include 'EXCHANGE_URL : \'123456\',' }
      its(:content) { should include 'TCOMP_STATIC_IPS: \'890,123,321\',' }
      its(:content) { should_not include 'MIXPANEL_ENABLED: true,' }
      its(:content) { should_not include 'MIXPANEL_IPAAS_KEY: \'qwerty\',' }
      its(:content) { should include 'PENDO_ENABLED: true,' }
      its(:content) { should include 'PENDO_IPAAS_KEY: \'asdfgh\',' }
      its(:content) { should include 'PENDO_CLOUD_PROVIDER: \'MyCloud\',' }
      its(:content) { should include 'PENDO_REGION: \'PENDO-REGION\',' }
    end

    %w(
    /srv/tomcat/ipaas-srv/webapps/ipaas/config/config.js
    ).each do |f|
      describe file(f) do
        it { should be_file }
      end
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/web.xml') do
      its(:content) { should include '<secure>true</secure>' }
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/ipaas_server.properties') do
      its(:content) { should include 'container_management_url=http://testcmsnode:8181/services/container-management-service' }
      its(:content) { should include 'flow_manager_url=http://flow_manager_url' }
      its(:content) { should include 'scim_service_url=http://scim-test-node' }
      its(:content) { should_not include 'flow_manager_node' }
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/api/WEB-INF/classes/ipaas_api.properties') do
      its(:content) { should_not include 'scim_service_url=http://scim-test-node' }
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/config.properties') do
      its(:content) { should_not include 'scim_service_url=http://scim-test-node' }
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas/resources/tic_s3_access.template') do
      its(:content) { should include 'arn:aws:iam::1234567890:root' }
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas-services/WEB-INF/classes/config.properties') do
      its(:content) { should include 'workspace_service_url=http://localhost:8081/ipaas-server/services' }
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas/WEB-INF/classes/application.properties') do
      its(:content) { should include 'security.oauth2.client.clientId = client_clientId' }
      its(:content) { should include 'security.oauth2.client.clientSecret = client_clientSecret' }
    end

    describe file('/srv/tomcat/ipaas-srv/webapps/ipaas-server/WEB-INF/classes/application.properties') do
      its(:content) { should include 'clientId = server_clientId' }
      its(:content) { should include 'security.oauth2.client.clientSecret = server_clientSecret' }
      its(:content) { should include 'security.oauth2.resource.tokenInfoUri = http://scim-test-node' }
      its(:content) { should include 'security.oidc.client.keyUri = http://scim-test-node' }
    end
  end

  context 'When TIC Frontend is running' do
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
