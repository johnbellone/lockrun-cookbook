#
# Cookbook Name:: lockrun
# Library:: matchers
#
# Copyright (C) 2014 John Bellone (<jbellone@bloomberg.net>)
#

if defined?(ChefSpec)
  def create_lockrun_cron(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:lockrun_cron, :create, resource_name)
  end

  def delete_lockrun_cron(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:lockrun_cron, :delete, resource_name)
  end
end
