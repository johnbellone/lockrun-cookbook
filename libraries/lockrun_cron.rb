#
# Cookbook: lockrun
# License: Apache 2.0
#
# Copyright (C) 2014, 2015 Bloomberg Finance L.P.
#
require 'poise'

module LockrunCookbook
  module Resource
    # @since 1.0.0
    class LockrunCron < Chef::Resource
      include Poise(fused: true)
      provides(:lockrun_cron)

      attribute(:command, kind_of: [String, Array], required: true)
      attribute(:lockfile_path, kind_of: String, default: '/var/run')
      attribute(:maxtime, kind_of: Integer)
      attribute(:quiet, equal_to: [true, false], default: false)
      attribute(:wait, equal_to: [true, false], default: false)
      attribute(:verbose, equal_to: [true, false], default: false)
      attribute(:environment, kind_of: Hash, default: { 'PATH' => '/usr/local/bin:/usr/bin:/bin' })
      attribute(:cron_options, option_collector: true, default: {})

      # @since 1.0.0
      action(:create) do
        lockrun = ['/usr/bin/env lockrun']
        lockrun << "--lockfile=#{new_resource.lockfile_path}/#{new_resource.name}.lockrun"
        lockrun << "--maxtime=#{new_resource.maxtime}" if new_resource.maxtime
        lockrun << '--quiet' if new_resource.quiet
        lockrun << '--wait' if new_resource.wait
        lockrun << '--verbose' if new_resource.verbose

        notifying_block do
          cron new_resource.name do |r|
            command [lockrun, '--', new_resource.command].join(' ')
            environment new_resource.environment
            new_resource.cron_options.each_pair { |k, v| r.send(k, v) }
          end
        end
      end

      # @since 1.0.0
      action(:delete) do
        notifying_block do
          cron new_resource.name do
            action :delete
          end
        end
      end
    end
  end
end
