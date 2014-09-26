#
# Cookbook Name:: lockrun
# Recipe:: default
#
# Copyright (C) 2014 John Bellone (<jbellone@bloomberg.net>)
#
include_recipe 'build-essential::default'

directory node['lockrun']['lock_path'] do
  recursive true
  group node['lockrun']['group']
  mode 0774
  not_if { ::Dir.exist? node['lockrun']['lock_path'] }
end

lockrun_file = File.join(Chef::Config[:file_cache_path], 'lockrun.c')
cookbook_file lockrun_file do
  not_if { ::File.exist? lockrun_file }
end

output_executable = File.join(node['lockrun']['install_prefix'], 'lockrun')
bash 'build-lockrun' do
  code (<<-CODE)
/usr/bin/env cc #{lockrun_file} -o #{output_executable}
chmod 0755 #{output_executable}
CODE
  not_if { ::File.exist? output_executable }
end
