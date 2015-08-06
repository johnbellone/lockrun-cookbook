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

if node['lockrun']['install_method'] == 'binary'
  basename = File.basename(node['lockrun']['binary_url'])
  remote_file File.join(Chef::Config[:file_cache_path], basename) do
    source node['lockrun']['binary_url']
    checksum node['lockrun']['binary_checksum'] if node['lockrun']['binary_checksum']
    notifies :extract, "libarchive_file[#{basename}]", :immediately
  end

  libarchive_file basename do
    action :nothing
    path File.join(Chef::Config[:file_cache_path], basename)
    extract_to '/usr/local/bin'
  end
end

if node['lockrun']['install_method'] == 'source'
  include_recipe 'build-essential::default'

  cookbook_file File.join(Chef::Config[:file_cache_path], 'lockrun.c') do
    source 'lockrun.c'
  end

  execute "gcc -o /usr/local/bin/lockrun #{File.join(Chef::Config[:file_cache_path], 'lockrun.c')}"
end
