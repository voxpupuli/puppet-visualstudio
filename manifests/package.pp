# Class windows_visualstudio
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
class windows_visualstudio::package(
  $ensure = 'present', 
  $deployment_root = hiera('windows_deployment_root'),
  $version = hiera('visualstudio_version'), 
  $edition = hiera('visualstudio_edition'),
  $components = [], 
  $license_key = hiera('visualstudio_license_key'),

) {

  $temp_dir = 'C:\\Windows\\Temp'
  
  $component_list = [
  'WebTools', 'OfficeTools', 'SharepointTools', 'LightSwitch', 'SilverLight_Developer_Kit',
  'SQL','VC_MFC_Libraries','Blend','BlissHidden','HelpHidden', 'LocalDBHidden', 'NetFX4Hidden',
  'NetFX45Hidden','PortableDTPHidden','PreEmptiveDotfuscatorHidden','PreEmptiveAnalyticsHidden',
  'ProfilerHidden','ReportingHidden','RIAHidden','SDKTools3Hidden','SDKTools4Hidden','Silverlight5DRTHidden',
  'SQLCEHidden','SQLCEToolsHidden','SQLCLRTypesHidden','SQLDACHidden','SQLDbProviderHidden','SQLDOMHidden',
  'SQLSharedManagementObjectsHidden','TSQLHidden','VCCompilerHidden','VCCoreHidden','VCDebugHidden',
  'VCDesigntimeHidden','VCExtendedHidden','WCFDataServicesHidden','WinJSHidden','WinSDKHidden'
  ]

  case $version {
    '2012': {
      $vs_root = "${deployment_root}\\VS2012\\${edition}\\"
      $vs_reg_key = 'HKLM:\\SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{17c2e197-cf26-443b-8beb-53151940df3f}'
    }
    default: {
      if $ensure == 'present' {
        notify { "visual studio does not have a version: ${version}": }
      }
    } 
  }
    
  if size($components) == 0 {
    $compnents = $windows_visualstudio::components_list
  }
    
  if $ensure == 'present' {
    file { "${temp_dir}\\visualstudio_config.xml":
      content => template('windows_visualstudio/AdminDeployment.xml.erb'),
      mode    => '0755',
      owner   => 'Administrator',
      group   => 'Administrators',
    }

    exec { 'install-visualstudio':
      command   => "\"& ${vs_root}\\vs_${edition}.exe\" /adminfile \"${temp_dir}\\visualstudio_config.xml\" /quiet /norestart",
      provider  => powershell,
      logoutput => true,
      unless    => "if ((Get-Item -LiteralPath \'\\${vs_reg_key}\' -ErrorAction SilentlyContinue).GetValue(\'DisplayVersion\')) { exit 1 }",
      require   => File["${temp_dir}\\visualstudio_config.xml"]
    }
  } elsif $ensure == 'absent' {
    exec { 'uninstall-visualstudio':
      command   => "& ${vs_root}\\vs_${edition}.exe /uninstall /quiet /norestart",
      provider  => powershell,
      logoutput => true,
      onlyif    => "if ((Get-Item -LiteralPath \'\\${vs_reg_key}\' -ErrorAction SilentlyContinue).GetValue(\'DisplayVersion\')) { exit 1 }"
    }
  } else {
    notify { "do not understand ensure agrument: ${ensure}": }
  }
}