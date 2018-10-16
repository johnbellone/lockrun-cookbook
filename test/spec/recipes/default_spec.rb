require 'spec_helper'

describe_recipe 'lockrun::default' do
  context 'with default attributes' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(file_cache_path: '/tmp').converge(described_recipe)
    end

    it do
      expect(chef_run).to create_cookbook_file('/tmp/lockrun.c')
        .with(source: 'lockrun.c')
    end

    it { expect(chef_run).to run_execute('gcc -o /usr/local/bin/lockrun /tmp/lockrun.c') }
  end

  context "with node['lockrun']['install_method'] == 'package'" do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(file_cache_path: '/tmp') do |node|
        node.set['lockrun']['install_method'] = 'package'
        node.set['lockrun']['package_version'] = '1.1.3'
      end.converge(described_recipe)
    end

    it { expect(chef_run).to upgrade_package('lockrun').with(version: '1.1.3') }

    it 'converges successfully' do
      chef_run
    end
  end

  context "with node['lockrun']['install_method'] == 'binary'" do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(file_cache_path: '/tmp') do |node|
        node.set['lockrun']['install_method'] = 'binary'
        node.set['lockrun']['binary_url'] = 'http://foo.bar.baz/lockrun.tar.gz'
        node.set['lockrun']['binary_checksum'] = 'deadb33f'
      end.converge(described_recipe)
    end

    it do
      expect(chef_run).to create_remote_file('/tmp/lockrun.tar.gz')
        .with(source: 'http://foo.bar.baz/lockrun.tar.gz')
        .with(checksum: 'deadb33f')
    end

    it do
      remote_file = chef_run.remote_file('/tmp/lockrun.tar.gz')
      expect(remote_file).to notify('libarchive_file[lockrun.tar.gz]').to(:extract).immediately
    end

    # TODO: https://github.com/reset/libarchive-cookbook/pull/16
    # it do
    #   archive_file = chef_run.libarchive_file('lockrun.tar.gz')
    #   expect(archive_file).to do_nothing
    # end

    it 'converges successfully' do
      chef_run
    end
  end
end
