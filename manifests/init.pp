# @summary
#   Module to manage the installation of Microsoft Visual Studio
#
# @param version
#   The version of visual studio to install
#
# @param edition
#   The edition of visual studio
#
# @param components
#   The list of components to install as part of the visual studio suite
#
# @param license_key
#   The license key required to install
#
# @param ensure
#   Control the existence of visualstudio
#
# @param deployment_root
#   Network location where the visual studio packages are located
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
  Pattern['^(2012)$'] $version,
  $edition,
  Pattern['([A-Z1-9]{5})-([A-Z1-9]{5})-([A-Z1-9]{5})-([A-Z1-9]{5})-([A-Z1-9]{5})$'] $license_key,
  $deployment_root,
  Array $components = [],
  Enum['present','absent'] $ensure = 'present'
) {
  include visualstudio::params

  #For now we might want to ignore this, this cannot be easily rewritten as a datatype
  #$edition_regex = join($visualstudio::params::vs_versions[$version]['editions'], '|')
  #validate_re($edition,"^${edition_regex}$", 'The edition argument does not match a valid edition for the specified version of visual studio')

  visualstudio::package { "visual studio ${version}":
    ensure          => $ensure,
    version         => $version,
    edition         => $edition,
    license_key     => $license_key,
    components      => $components,
    deployment_root => $deployment_root,
  }
}
