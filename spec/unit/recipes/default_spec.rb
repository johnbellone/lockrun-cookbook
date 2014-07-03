require 'spec_helper'

describe 'lockrun::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') }

  context 'directory[lock_path]' do
    it do
      chef_run.node.set['lockrun']['lock_path'] = '/tmp/lockrun'
      chef_run.converge(described_recipe)

      expect(chef_run).to create_directory('/tmp/lockrun')
    end

    it do
      chef_run.converge(described_recipe)
      expect(chef_run).not_to create_directory('/var/run')
    end
  end

  context 'cookbook_file[lockrun.c]' do
    before { chef_run.converge(described_recipe) }

    it { expect(chef_run).to create_cookbook_file(File.join(Chef::Config[:file_cache_path], 'lockrun.c')) }
  end

  context 'bash[build-lockrun]' do
    before { chef_run.converge(described_recipe) }

    it { expect(chef_run).to run_bash('build-lockrun') }
  end
end
