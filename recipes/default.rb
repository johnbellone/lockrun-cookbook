#
# Cookbook: lockrun
# License: Apache 2.0
#
# Copyright (C) 2014, 2015 Bloomberg Finance L.P.
#
package node['lockrun']['package_name'] do
  action :upgrade

  version node['lockrun']['package_version'] if node['lockrun']['package_version']
  only_if { node['lockrun']['install_method'] == 'package' }
end
