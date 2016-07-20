require 'spec_helper'

describe 'engine' do
  describe package('talend-ipaas-rt-flow') do
    it { should be_installed }
  end

  describe command('/opt/talend/ipaas/rt-flow/bin/client -u tadmin shell:info') do
    its(:exit_status) { should eq 0 }
    describe '#stdout' do
      subject { super().stdout }
      it { should include 'Oracle Corporation' }
      it { should include 'Karaf version' }
    end
  end

  describe command('/opt/talend/ipaas/rt-flow/bin/client -u tadmin log:display') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should_not include 'ERROR' }
  end

  describe command('/opt/talend/ipaas/rt-flow/bin/shell "wrapper:install --help"') do
    its(:stdout) { should include 'Install the container as a system service in the OS' }
  end

  describe service('rt-flow-service-lxc') do
    it { should be_enabled }
    it { should be_running.under('systemd') }
  end

  describe 'Service configuration' do
    subject { file('/opt/talend/ipaas/rt-flow/etc/rt-flow-service-lxc-wrapper.conf').content }
    it { should match /wrapper.jvm_kill.delay\s*=\s*5/ }
    it { should match /wrapper.java.additional.10\s*=\s*-XX:MaxPermSize=256m/ }
    it { should match /wrapper.java.additional.11\s*=\s*\-XX:OnOutOfMemoryError=\/opt\/talend\/ipaas\/rt\-flow\/scripts\/oomkiller4j.sh/ }
    it { should match /wrapper.java.additional.12\s*=\s*-Dcom.sun.management.jmxremote.port=7199/ }
    it { should match /wrapper.java.additional.13\s*=\s*-Dcom.sun.management.jmxremote.authenticate=false/ }
    it { should match /wrapper.java.additional.14\s*=\s*-Dcom.sun.management.jmxremote.ssl=false/ }
    it { should match /wrapper.java.maxmemory\s*=\s*1024/ }
    it { should match /wrapper.disable_restarts\s*=\s*true/ }
  end
end
