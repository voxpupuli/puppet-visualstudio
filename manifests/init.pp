# == Define: visualstudio
#
# Module to manage the installation of Microsoft Visual Studio
#
# === Requirements/Dependencies
#
# Currently reequires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*version*]
# The version of visual studio to install
#
# [*edition*]
# The edition of visual studio
#
# [*component*]
# The list of components to install as part of the visual studio suite
#
# [*license_key*]
# The license key required to install
#
# [*ensure*]
# Control the existence of visualstudio
#
# [*deployment_root*]
# Network location where the visual studio packages are located
#
# === Examples:
#
#  Install visual studio 2012:
#
#    visualstudio { "visual studio 2012":
#      ensure      => 'present',
#      version     => '2012',
#      edition     => 'professional',
#      license_key => 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX',
#      deployment_root => '\\server.mydomain.com\packages\VS2012'
#    }
#
define visualstudio (
  $version,
  $edition,
  $license_key,
  $deployment_root,
  $components = [],
  $ensure = 'present'
) {
  include visualstudio::params

  validate_re($version,'^(2012)$', 'The version argument specified does not match a supported version of visual studio')

  $edition_regex = join($visualstudio::params::vs_versions[$version]['editions'], '|')
  validate_re($edition,"^${edition_regex}$", 'The edition argument does not match a valid edition for the specified version of visual studio')

  validate_re($license_key,'([A-Z1-9]{5})-([A-Z1-9]{5})-([A-Z1-9]{5})-([A-Z1-9]{5})-([A-Z1-9]{5})$', 'The license_key argument speicifed is not correctly formatted')

  validate_array($components)

  validate_re($ensure,'^(present|absent)$', 'The ensure argument does not match present or absent')

  visualstudio::package { "visual studio ${version}":
    ensure          => $ensure,
    version         => $version,
    edition         => $edition,
    license_key     => $license_key,
    components      => $components,
    deployment_root => $deployment_root,
  }
}
