require 'spec_helper'

describe 'visualstudio::params', :type => :class do
  let :hiera_data do
    {
        :windows_deployment_root => '\\test-server\packages',
    }
  end

  #TODO: why doesn't this work?
  #it { should have_resource_count(0) }
end