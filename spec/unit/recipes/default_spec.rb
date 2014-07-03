require 'spec_helper'

describe 'lockrun::default' do
  let(:chef_run) { ChefSpec::Runner.new }

  context 'directory[lock_path]' do
    before do
      chef_run.node.set['lockrun']['lock_path'] = '/tmp/lockrun'
      chef_run.converge(described_recipe)
    end

    it { expect(chef_run).to create_directory('/tmp/lockrun') }
  end

  context 'cookbook_file[lockrun.c]' do
    let(:cache_file) { File.join(Chef::Config[:file_cache_path], 'lockrun.c') }
    before { chef_run.converge(described_recipe) }

    it { expect(chef_run).to create_cookbook_file(cache_file) }
  end

  context 'bash[build-lockrun]' do
    before { chef_run.converge(described_recipe) }

    it { expect(chef_run).to run_bash('build-lockrun') }
  end
end
