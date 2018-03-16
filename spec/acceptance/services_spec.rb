require 'spec_helper'

describe 'services' do
  describe package('talend-ipaas-rt-infra') do
    it { should be_installed }
  end

  describe command('/opt/talend/ipaas/rt-infra/bin/shell "wrapper:install --help"') do
    its(:stdout) { should include 'Install the container as a system service in the OS' }
  end

  describe service('karaf') do
    it { should be_enabled }
    it { should be_running.under('systemd') }
  end

  describe 'Service configuration' do
    subject { file('/opt/talend/ipaas/rt-infra/etc/karaf-wrapper.conf').content }
    it { should match /wrapper.jvm_kill.delay\s*=\s*5/ }
    it { should match /wrapper.java.additional.10\s*=\s*-XX:MaxMetaspaceSize=256m/ }
    it { should match /wrapper.java.additional.11\s*=\s*-Dcom.sun.management.jmxremote.port=7199/ }
    it { should match /wrapper.java.additional.12\s*=\s*-Dcom.sun.management.jmxremote.authenticate=false/ }
    it { should match /wrapper.java.additional.13\s*=\s*-Dcom.sun.management.jmxremote.ssl=false/ }
    it { should match /wrapper.java.maxmemory\s*=\s*1024/ }
    it { should match /wrapper.disable_restarts\s*=\s*true/ }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.eventsource.amq.cfg') do
    its(:content) { should include 'activemq.broker.password=activemq_broker_test_password' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.eventsource.amq.cfg') do
    its(:content) { should include 'activemq.broker.username=activemq_broker_test_username' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.ams.core.cfg') do
    its(:content) { should match /amq_security\s*=\s*false/ }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.pe.client.cfg') do
    its(:content) { should include 'pe.service.username=pe_service_test_username' }
    its(:content) { should include 'pe.service.password=missing' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.flowmanager.cfg') do
    its(:content) { should include 'time.to.unknown=999' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/quartz.properties') do
    its(:content) { should match /org.quartz.scheduler.instanceId\s*=\s*my-instance-id/ }
    its(:content) { should match /org.quartz.jobStore.isClustered\s*=\s*false/ }
    its(:content) { should match /org.quartz.jobStore.clusterCheckinInterval\s*=\s*777/ }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.dispatcher.nodemanager.aws.cfg') do
    its(:content) { should include '"t_environment": "test_env"' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.ops4j.pax.web.cfg') do
    its(:content) { should include 'org.osgi.service.http.port=8282' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.lts.client.cfg') do
    its(:content) { should include 'log.transfer.admin.url=logs_admin_url' }
    its(:content) { should include 'log.transfer.admin.username=logs_admin_username' }
    its(:content) { should include 'log.transfer.admin.password=logs_admin_password' }
    its(:content) { should include 'log.transfer.upload.url=logs_upload_url' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.iam.scim.client.cfg') do
    its(:content) { should include 'iam-test-url' }
    its(:content) { should include 'http://scim-test-node' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.bookkeeper.zk.backend.cfg') do
    its(:content) { should include 'zk.path=/zookeeper/path/prefix' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.notification.subscription.service.cfg') do
    its(:content) { should include 'memcached.connectionString = my-memcached-host:my-memcached-port' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.zipkin.cfg') do
    its(:content) { should include 'zipkin.enabled = true' }
    its(:content) { should include 'zipkin.kafka.topic = zipkin' }
    its(:content) { should include 'zipkin.kafka.bootstrapServers = localhost:9999' }
    its(:content) { should include 'zipkin.sampler.percentage = 0.3' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.webhooks.client.cfg') do
    its(:content) { should include 'webhooks.service.url=webhook-test-url' }
  end

  describe file('/opt/talend/ipaas/rt-infra/etc/org.talend.ipaas.rt.cms.cfg') do
    its(:content) { should include 'license-management.url = http://license-management-node' }
  end

  describe file('/opt/talend/ipaas/rt-infra/bin/karaf.service') do
    its(:content) { should_not include 'WantedBy=default.target' }
  end
end
