name             'lockrun'
maintainer       'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license          'Apache 2.0'
description      'Installs lockrun executable for running cronjobs with overrun protection.'
long_description 'Installs lockrun executable for running cronjobs with overrun protection.'
version          '0.2.3'

%w(centos redhat).each do |name|
  supports name, '~> 7.0'
  supports name, '~> 6.4'
  supports name, '~> 5.8'
end

supports 'ubuntu', '= 14.04'
supports 'ubuntu', '= 12.04'

depends 'build-essential'
depends 'poise'
