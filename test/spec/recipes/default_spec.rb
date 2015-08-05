require 'spec_helper'

describe_recipe 'lockrun::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  context 'with default attributes' do
    it { expect(chef_run).to upgrade_package('lockrun').with(version: '1.1.3') }

    it 'converges successfully' do
      chef_run
    end
  end
end
