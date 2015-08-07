# lockrun-cookbook
![Release](http://img.shields.io/github/release/johnbellone/lockrun-cookbook.svg)
[![Build Status](http://img.shields.io/travis/johnbellone/lockrun-cookbook.svg)][2]
[![Code Coverage](http://img.shields.io/coveralls/johnbellone/lockrun-cookbook.svg)][3]

Installs the [lockrun][0] executable for running cronjobs with overrun
protection.

## Basic Usage
This cookbook is extremely useful when you only want to have a _single_
process running at a time. We use this to ensure that there is only ever
one Chef Client running at a time. If a process already has the lock it
bails out immediately.

Instead of writing a wrapper script every time you want this
functionality simply use the lockrun executable. It counts the number
of open file descriptors to a lockfile on disk.
```ruby
include_recipe 'lockrun::default'

sleep_time = 0
unless node['chef_client']['splay'].to_i == 0
  checksum   = Digest::MD5.hexdigest(node['fqdn'] || 'unknown-hostname')
  sleep_time = checksum.to_s.hex % node['chef_client']['splay'].to_i
end

lockrun_cron 'chef-client' do
  command "/bin/sleep #{sleep_time}; chef-client > /dev/null 2>&1"
  cron_options(minute: '0', hour: '*', weekday: '*')
end
```

Out of the box the following platforms are certified to work and
are tested using our [Test Kitchen][8] configuration. Additional platforms
_may_ work, but your mileage may vary.
- CentOS (RHEL) 5.8, 6.6, 7.1
- Ubuntu 12.04, 14.04


[0]: http://www.unixwiz.net/tools/lockrun.html
[1]: https://github.com/johnbellone
[2]: http://travis-ci.org/johnbellone/lockrun-cookbook
[3]: https://coveralls.io/r/johnbellone/lockrun-cookbook
