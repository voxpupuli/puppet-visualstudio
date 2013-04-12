# Class visualstudio
#
# This class installs the Microsoft Visual Studio on windows
#
# Parameters:
#   [*ensure*]          - Control the existence of office    
#   [*deployment_root*] - The network location to go and find the package
#   [*version*]         - The version of visual studio to install
#   [*edition*]         - The edition of visual studio
#   [*component*]       - The list of components to install as part of the visual studio suite
#   [*license_key*]     - The license key required to install
#
# Actions:
#
# Requires:
#
# Usage:
#
#   class { 'visualstudio': 
#     ensure => present,
#     version => '2010',
#     edition => 'Professional',
#     license_key => 'XXX-XXX-XXX-XXX-XXX'
#   }
class visualstudio(
  $ensure = 'present', 
  $deployment_root = hiera('windows_deployment_root'),
  $version = hiera('visualstudio_version'), 
  $edition = hiera('visualstudio_edition'),
  $components = [], 
  $license_key = hiera('visualstudio_license_key'),
) {
  
  class { 'visualstudio::package':
    ensure      => $ensure,
    version     => $version,
    edition     => $edition,
    components  => $components,
    license_key => $license_key
  }
    
}
