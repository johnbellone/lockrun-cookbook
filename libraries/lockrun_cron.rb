#
# Cookbook Name:: lockrun
# Library:: lockrun_cron
#
# Copyright (C) 2014 John Bellone (<jbellone@bloomberg.net>)
#
class Chef
  # Define a resource which inherits from Chef::Resource::Cron and
  # wraps the `command` with overrun protection.
  class Resource::LockrunCron < Resource::Cron
    include Poise

    attribute(:lockfile, kind_of: String, default: lazy { })
    attribute(:maxtime, kind_of: Integer, default: nil)
    attribute(:quiet, kind_of: [TrueClass, FalseClass], default: false)
    attribute(:verbose, kind_of: [TrueClass, FalseClass], default: false)
    attribute(:wait, kind_of: [TrueClass, FalseClass], default: false)

    # Set or return a `command` from the Chef::Resource::Cron resource.
    # @param arg [String] Argument to be written to the node's crontab.
    # @return [String] Wrapped `arg` with a lockrun statement.
    def command(arg=nil)
      # Support the original behavior of Chef::Resource#set_or_return.
      return super unless arg

      # Wrap the command (see Chef::Resource::Cron#command) with a statement
      # based on the resource attributes configured.
      cmd = "/usr/bin/env lockrun --lockfile=#{new_resource.lockfile}"
      cmd << ' --quiet' if new_resource.quiet?
      cmd << ' --wait' if new_resource.wait?
      cmd << ' --verbose' if new_resource.verbose?
      cmd << " --maxtime=#{new_resource.maxtime}" if new_resource.maxtime
      super cmd.concat(" -- #{arg}")
    end
  end
end
