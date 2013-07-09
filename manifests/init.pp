# Define visualstudio
#
# This definition installs the Microsoft Visual Studio on windows
#
# Parameters:
#   [*version*]         - The version of visual studio to install
#   [*edition*]         - The edition of visual studio
#   [*component*]       - The list of components to install as part of the visual studio suite
#   [*license_key*]     - The license key required to install
#   [*ensure*]          - Control the existence of visualstudio
#
# Actions:
#
# Requires:
#
# Usage:
#
#     visualstudio { "visual studio":
#       ensure      => $ensure,
#       version     => $version,
#       edition     => $edition,
#       license_key => $license_key,
#       components  => $components,
#    }
define visualstudio(
  $version,
  $edition,
  $license_key,
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
    ensure      => $ensure,
    version     => $version,
    edition     => $edition,
    license_key => $license_key,
    components  => $components,
  }

}