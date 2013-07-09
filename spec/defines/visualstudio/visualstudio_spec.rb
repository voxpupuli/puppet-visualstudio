require 'spec_helper'

describe 'visualstudio', :type => :define do

  let :hiera_data do
    {
        :windows_deployment_root => '\\test-server\packages',
    }
  end

  describe "installing with unknown version" do
    let :title do "visual studio with unknown version" end
    let :params do
      { :version => 'xxx', :edition => 'Professional', :license_key => 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX' }
    end

    it do
      expect {
        should contain_visualstudio__package("visual studio 2012")
      }.to raise_error(Puppet::Error) {|e| expect(e.to_s).to match 'The version argument specified does not match a supported version of visual studio' }
    end
  end

  ['2012'].each do |version|
    describe "installing #{version} with wrong edition" do
      let :title do "visual studio for #{version}" end
      let :params do
        { :version => version, :edition => "fubat", :license_key => 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX'}
      end

      it do
        expect {
          should contain_visualstudio__package("visual studio #{version}")
        }.to raise_error(Puppet::Error) {|e| expect(e.to_s).to match 'The edition argument does not match a valid edition for the specified version of visual studio' }
      end
    end
  end

  describe "incorrect license key" do
    let :title do "visual studio with incorrect license key" end
    let :params do
      { :version => '2012', :edition => "Professional", :license_key => 'XXXXX-XXXXX-XXXX-XXXXX-XXXXX'}
    end

    it do
      expect {
        should contain_visualstudio__package("visual studio 2012")
      }.to raise_error(Puppet::Error) {|e| expect(e.to_s).to match 'The license_key argument speicifed is not correctly formatted' }
    end
  end

  describe "incorrect ensure" do
    let :title do "visual studio with incorrect ensure" end
    let :params do
      { :ensure => 'fubar', :version => '2012', :edition => "Professional", :license_key => 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX'}
    end

    it do
      expect {
        should contain_visualstudio__package("visual studio 2012")
      }.to raise_error(Puppet::Error) {|e| expect(e.to_s).to match 'The ensure argument does not match present or absent' }
    end
  end

  ['2012'].each do |version|
    describe "installs the core package for #{version}" do
      let :title do "visual studio #{version}" end
      let :params do
        { :version => version, :edition => 'Professional', :license_key => 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX'}
      end

      it { should contain_visualstudio__package("visual studio #{version}")}
    end
  end
end