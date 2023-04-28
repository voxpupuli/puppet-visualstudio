# frozen_string_literal: true

require 'spec_helper'

describe 'visualstudio::package', type: :define do
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
      end.to raise_error
    end
  end

  ['2012'].each do |version|
    describe "installing #{version} with wrong edition" do
      let(:title) { "visual studio for #{version}" }
      let(:params) do
        {
          version: version,
          edition: 'fubar',
          license_key: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
          deployment_root: '\\test-server\packages'
        }
      end

      it do
        expect do
          is_expected.to contain_visualstudio__package("visual studio #{version}")
        end.to raise_error
      end
    end
  end

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
      end.to raise_error
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
      end.to raise_error
    end
  end

  ['Professional', 'Test Professional', 'Premium', 'Ultimate'].each do |edition|
    describe "installing visualstudio 2012 #{edition}" do
      let(:title) { 'visual studio 2012' }
      let(:params) do
        {
          version: '2012',
          edition: edition,
          license_key: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
          deployment_root: '\\test-server\packages'
        }
      end

      it do
        is_expected.to contain_exec('install-visualstudio').with(
          'command' => "& \"\\test-server\\packages\\VS2012\\#{edition}\\vs_#{edition}.exe\" /adminfile \"C:\\Windows\\Temp\\visualstudio_config.xml\" /quiet /norestart",
          'provider' => 'powershell'
        )
      end
    end
  end

  ['Professional', 'Test Professional', 'Premium', 'Ultimate'].each do |edition|
    describe "uninstalling visualstudio 2012 #{edition}" do
      let(:title) { 'visual studio 2012' }
      let(:params) do
        {
          version: '2012',
          edition: edition,
          license_key: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
          ensure: 'absent',
          deployment_root: '\\test-server\packages'
        }
      end

      it do
        is_expected.to contain_exec('uninstall-visualstudio').with(
          'command' => "& \"\\test-server\\packages\\VS2012\\#{edition}\\vs_#{edition}.exe\" /uninstall /quiet /norestart",
          'provider' => 'powershell'
        )
      end
    end
  end
end
