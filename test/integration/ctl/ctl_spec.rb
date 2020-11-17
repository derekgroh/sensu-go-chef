#
# Cookbook:: sensu-go
# Spec:: ctl
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# The following are only examples, check out https://github.com/chef/inspec/tree/master/docs
# for everything you can do.
if os.linux?
  case os.redhat?
  when 'fedora' || 'amazon'
    describe yum.repo('sensu_stable') do
      it { should exist }
      it { should be_enabled }
    end
  when 'debian' || 'ubuntu'
    describe apt("https://packagecloud.io/sensu/stable/#{os.name}") do
      it { should exist }
      it { should be_enabled }
    end
  end

  describe package('sensu-go-cli') do
    it { should be_installed }
  end
end

if os.windows?
  describe command('cmd.exe /c "echo %PATH%"') do
    its('stdout') { should include 'c:\Program Files\Sensu\sensu-cli\bin\sensuctl' }
  end

  describe chocolatey_package('sensu-cli') do
    it { should be_installed }
  end
end

describe command('sensuctl user list') do
  its('stdout') { should match /Username/ }
  its('exit_status') { should eq 0 }
end
