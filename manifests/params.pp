# Author::    Liam Bennett (mailto:liamjbennett@gmail.com)
# Copyright:: Copyright (c) 2014 Liam Bennett
# License::   MIT

# == Class visualstudio::params
#
# This private class is meant to be called from `visualstudio`
# It sets variables according to platform
#
class visualstudio::params {
  $temp_dir = 'C:\\Windows\\Temp'
  $deployment_root = ''

  $component_list = [
    'WebTools', 'OfficeTools', 'SharepointTools', 'LightSwitch', 'SilverLight_Developer_Kit',
    'SQL','VC_MFC_Libraries','Blend','BlissHidden','HelpHidden', 'LocalDBHidden', 'NetFX4Hidden',
    'NetFX45Hidden','PortableDTPHidden','PreEmptiveDotfuscatorHidden','PreEmptiveAnalyticsHidden',
    'ProfilerHidden','ReportingHidden','RIAHidden','SDKTools3Hidden','SDKTools4Hidden','Silverlight5DRTHidden',
    'SQLCEHidden','SQLCEToolsHidden','SQLCLRTypesHidden','SQLDACHidden','SQLDbProviderHidden','SQLDOMHidden',
    'SQLSharedManagementObjectsHidden','TSQLHidden','VCCompilerHidden','VCCoreHidden','VCDebugHidden',
    'VCDesigntimeHidden','VCExtendedHidden','WCFDataServicesHidden','WinJSHidden','WinSDKHidden'
  ]

  $vs_versions = {
    '2012' => {
      'editions' => ['Ultimate','Premium','Test Professional','Professional']
    }
  }
}
