describe command 'lockrun' do
  it { should exist }
end

describe crontab('root').commands '/usr/bin/env lockrun --lockfile=/var/run/chef-client.lockrun -- chef-client' do
  its('minutes') { should cmp 0 }
end
