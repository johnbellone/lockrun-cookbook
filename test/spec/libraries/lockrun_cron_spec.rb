require 'poise_boiler/spec_helper'
require_relative '../../../libraries/lockrun_cron'

describe LockrunCookbook::Resource::LockrunCron do
  step_into(:lockrun_cron)
  context '#action_create' do
    recipe do
      lockrun_cron 'chef-client' do
        command 'chef-client'
        cron_options(minute: '0', weekday: '*', hour: '*')
      end
    end

    it do
      is_expected.to create_cron('chef-client')
      .with(command: '/usr/bin/env lockrun --lockfile=/var/run/chef-client.lockrun -- chef-client')
      .with(minute: '0', weekday: '*', hour: '*')
      .with(environment: { 'PATH' => '/usr/local/bin:/usr/bin:/bin' })
    end
  end

  context '#action_delete' do
    recipe do
      lockrun_cron 'chef-client' do
        action :delete
      end
    end

    it { is_expected.to delete_cron('chef-client') }
  end
end
