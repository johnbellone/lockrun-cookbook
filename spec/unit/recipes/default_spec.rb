require 'spec_helper'

describe 'lockrun::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'creates lock path' do
    expect(chef_run).to_not create_directory(chef_run.node['lockrun']['lock_path'])
  end

  it 'includes build-essential::default' do
    expect(chef_run).to include_recipe('build-essential::default')
  end

  it 'builds lockrun' do
    expect(chef_run).to run_bash('build-lockrun')
  end
end
