Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.box = ENV.fetch('VAGRANT_BOX', 'opscode-centos-6.5')

  config.vm.provision :chef_solo do |chef|
    chef.run_list = ['lockrun::default']
  end
end
