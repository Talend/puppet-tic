Facter.add(:ipaas_rt_infra_installed_version) do
  confine :kernel => :Linux
  setcode do
    version = Facter::Util::Resolution.exec('rpm -q --queryformat "%{VERSION}.%{RELEASE}" talend-ipaas-rt-infra')
    if $?.exitstatus == 0
      version
    else
      nil
    end
  end
end
