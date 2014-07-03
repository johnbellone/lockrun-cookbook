Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true

  config.vm.box = ENV.fetch('VAGRANT_BOX', 'opscode-centos-6.5')

  config.vm.provisioner :chef_solo do |chef|
    chef.run_list = ['lockrun::default']
  end
end
