require 'spec_helper'

describe 'frontend' do

  describe port(8081) do
    it { should be_listening }
  end

  describe command('/usr/bin/wget -O - http://127.0.0.1:8081') do
    its(:stdout) { should include '<title>Talend Integration Cloud</title>' }
  end

end
