lockrun_cron 'chef-client' do
  command 'chef-client'
  cron_options(minute: '0', hour: '*', weekday: '*')
end
