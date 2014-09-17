require 'spec_helper'

describe 'lockrun::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') }

  it do
    chef_run.converge(described_recipe)
    expect(chef_run).to create_cookbook_file(File.join(Chef::Config[:file_cache_path], 'lockrun.c'))
  end

  it do
    chef_run.converge(described_recipe)
    expect(chef_run).to run_bash('build-lockrun')
  end

  context %Q(node['lockrun']['lock_path'] = '/tmp/lockrun.d') do
    before do
      chef_run.node.set['lockrun']['lock_path'] = '/tmp/lockrun.d'
      chef_run.converge(described_recipe)
    end

    it do
      expect(chef_run).to create_directory('/tmp/lockrun.d')
        .with(recursive: true)
    end
    it { expect(chef_run).not_to create_directory('/var/run/lockrun.d') }
  end

  context %Q(with default attributes) do
    before { chef_run.converge(described_recipe) }

    it do
      expect(chef_run).to create_directory('/var/run/lockrun.d')
        .with(recursive: true)
    end
    it { expect(chef_run).not_to create_directory('/tmp/lockrun.d') }
  end
end
