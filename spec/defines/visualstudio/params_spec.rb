require 'spec_helper'

describe 'visualstudio::params', type: :class do
  let :hiera_data do
    {
      windows_deployment_root: '\\test-server\packages'
    }
  end

  it { should have_resource_count(0) }
end
