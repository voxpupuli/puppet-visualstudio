require 'spec_helper'

describe 'visualstudio::package', :type => :define do


  describe 'installing with unknown version' do
    let :title do 'visual studio with unknown version' end
    let(:params) {{
      :version => 'xxx',
      :edition => 'Professional',
      :license_key => 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
      :deployment_root => '\\test-server\packages'
    }}

    it do
      expect {
        should contain_visualstudio__package('visual studio 2012')
      }.to raise_error
    end
  end

  ['2012'].each do |version|
    describe "installing #{version} with wrong edition" do
      let :title do "visual studio for #{version}" end
      let(:params) {{
        :version => version,
        :edition => 'fubar',
        :license_key => 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
        :deployment_root => '\\test-server\packages'
      }}

      it do
        expect {
          should contain_visualstudio__package("visual studio #{version}")
        }.to raise_error
      end
    end
  end

  describe "incorrect license key" do
    let :title do "visual studio with incorrect license key" end
    let(:params) {{
      :version => '2012',
      :edition => 'Professional',
      :license_key => 'XXXXX-XXXXX-XXXX-XXXXX-XXXXX',
      :deployment_root => '\\test-server\packages'
    }}

    it do
      expect {
        should contain_visualstudio__package("visual studio 2012")
      }.to raise_error
    end
  end

  describe "incorrect ensure" do
    let :title do "visual studio with incorrect ensure" end
    let(:params) {{
      :ensure => 'fubar',
      :version => '2012',
      :edition => 'Professional',
      :license_key => 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
      :deployment_root => '\\test-server\packages'
    }}

    it do
      expect {
        should contain_visualstudio__package("visual studio 2012")
      }.to raise_error
    end
  end

  ['Professional','Test Professional','Premium','Ultimate'].each do |edition|
    describe "installing visualstudio 2012 #{edition}" do
      let :title do 'visual studio 2012' end
      let(:params) {{
        :version => '2012',
        :edition => edition,
        :license_key => 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
        :deployment_root => '\\test-server\packages'
      }}

      it { should contain_exec('install-visualstudio').with(
        'command' => "& \"\\test-server\\packages\\VS2012\\#{edition}\\vs_#{edition}.exe\" /adminfile \"C:\\Windows\\Temp\\visualstudio_config.xml\" /quiet /norestart",
        'provider' => 'powershell'
      )}
    end
  end

  ['Professional','Test Professional','Premium','Ultimate'].each do |edition|
    describe "uninstalling visualstudio 2012 #{edition}" do
      let :title do 'visual studio 2012' end
      let(:params) {{
        :version => '2012',
        :edition => edition,
        :license_key => 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
        :ensure => 'absent',
        :deployment_root => '\\test-server\packages'
      }}

      it { should contain_exec('uninstall-visualstudio').with(
        'command' => "& \"\\test-server\\packages\\VS2012\\#{edition}\\vs_#{edition}.exe\" /uninstall /quiet /norestart",
        'provider' => 'powershell'
      )}
    end
  end

end
