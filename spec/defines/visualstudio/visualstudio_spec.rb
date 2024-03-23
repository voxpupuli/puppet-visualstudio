# frozen_string_literal: true

require 'spec_helper'

describe 'visualstudio', type: :define do
  describe 'installing with unknown version' do
    let(:title) { 'visual studio with unknown version' }
    let(:params) do
      {
        version: 'xxx',
        edition: 'Professional',
        license_key: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
        deployment_root: '\\test-server\packages'
      }
    end

    it do
      expect do
        is_expected.to contain_visualstudio__package('visual studio 2012')
      end.to raise_error(Puppet::PreformattedError)
    end
  end

  # Temporary disabled until edition regex check is fixed
  #  ['2012'].each do |version|
  #    describe "installing #{version} with wrong edition" do
  #      let(:title) { "visual studio for #{version}" }
  #      let(:params) do
  #        {
  #          version: version,
  #          edition: 'fubat',
  #          license_key: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
  #          deployment_root: '\\test-server\packages'
  #        }
  #      end
  #
  #
  #      it do
  #        expect do
  #          is_expected.to contain_visualstudio__package("visual studio #{version}")
  #        end.to raise_error(Puppet::Error)
  #      end
  #    end
  #  end

  describe 'incorrect license key' do
    let(:title) { 'visual studio with incorrect license key' }
    let(:params) do
      {
        version: '2012',
        edition: 'Professional',
        license_key: 'XXXXX-XXXXX-XXXX-XXXXX-XXXXX',
        deployment_root: '\\test-server\packages'
      }
    end

    it do
      expect do
        is_expected.to contain_visualstudio__package('visual studio 2012')
      end.to raise_error(Puppet::PreformattedError)
    end
  end

  describe 'incorrect ensure' do
    let(:title) { 'visual studio with incorrect ensure' }
    let(:params) do
      {
        ensure: 'fubar',
        version: '2012',
        edition: 'Professional',
        license_key: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
        deployment_root: '\\test-server\packages'
      }
    end

    it do
      expect do
        is_expected.to contain_visualstudio__package('visual studio 2012')
      end.to raise_error(Puppet::PreformattedError)
    end
  end

  ['2012'].each do |version|
    describe "installs the core package for #{version}" do
      let(:title) { "visual studio #{version}" }
      let(:params) do
        {
          version: version,
          edition: 'Professional',
          license_key: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
          deployment_root: '\\test-server\packages'
        }
      end

      it { is_expected.to contain_visualstudio__package("visual studio #{version}") }
    end
  end
end
