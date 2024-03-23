# @summary
#   Installs Virtualstudio. This private definition is meant to be called from `visualstudio`. It sets variables according to platform.
#
define visualstudio::package (
  Pattern['^(2012)'] $version,
  $edition,
  Pattern['^([A-Z1-9]{5})-([A-Z1-9]{5})-([A-Z1-9]{5})-([A-Z1-9]{5})-([A-Z1-9]{5})$'] $license_key,
  $deployment_root,
  Array $components = [],
  Enum['present','absent'] $ensure = 'present'
) {
  include visualstudio::params

  #For now we might want to ignore this, this cannot be easily rewritten as a datatype
  #$edition_regex = join($visualstudio::params::vs_versions[$version]['editions'], '|')
  #validate_re($edition,"^${edition_regex}$", 'The edition argument does not match a valid edition for the specified version of visual studio')

  case $version {
    '2012': {
      $vs_root = "${deployment_root}\\VS2012\\${edition}"
      $vs_reg_key = 'HKLM:\\SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{17c2e197-cf26-443b-8beb-53151940df3f}'
    }
    default: {
      if $ensure == 'present' {
        notify { "visual studio does not have a version: ${version}": }
      }
    }
  }

  if size($components) == 0 {
    $compnents = $visualstudio::params::component_list
  }

  if $ensure == 'present' {
    file { "${visualstudio::params::temp_dir}\\visualstudio_config.xml":
      content => template('visualstudio/AdminDeployment.xml.erb'),
      mode    => '0755',
      owner   => 'Administrator',
      group   => 'Administrators',
    }

    exec { 'install-visualstudio':
      command   => "& \"${vs_root}\\vs_${edition}.exe\" /adminfile \"${visualstudio::params::temp_dir}\\visualstudio_config.xml\" /quiet /norestart",
      provider  => powershell,
      logoutput => true,
      unless    => "if ((Get-Item -LiteralPath \'\\${vs_reg_key}\' -ErrorAction SilentlyContinue).GetValue(\'DisplayVersion\')) { exit 1 }",
      require   => File["${visualstudio::params::temp_dir}\\visualstudio_config.xml"],
    }
  } elsif $ensure == 'absent' {
    exec { 'uninstall-visualstudio':
      command   => "& \"${vs_root}\\vs_${edition}.exe\" /uninstall /quiet /norestart",
      provider  => powershell,
      logoutput => true,
      onlyif    => "if ((Get-Item -LiteralPath \'\\${vs_reg_key}\' -ErrorAction SilentlyContinue).GetValue(\'DisplayVersion\')) { exit 1 }",
    }
  } else {
    notify { "do not understand ensure agrument: ${ensure}": }
  }
}
