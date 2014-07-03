require 'spec_helper'

describe 'lockrun::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes build-essential::default' do
    expect(chef_run).to include_recipe('build-essential::default')
  end

  it 'builds lockrun' do
    expect(chef_run).to bash('build-lockrun')
  end
end
