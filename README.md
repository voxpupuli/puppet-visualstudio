#Microsoft Visual Studio module for Puppet


##Overview

Puppet module to manage Microsoft Visual Studio

This module is also available on the [Puppet Forge](https://forge.puppetlabs.com/liamjbennett/visualstudio)


##Module Description

The purpose of this module is to install the Microsoft Visual Studio suite and configure it's many service packs, tools, utilities and registry options.

##Setup

####How Visual Studio is installed

Installation will be performed from files stored on a pre-defined network shared in a known structure. This is described in more detail [Here]()
It will install the full visual studio suite unless only invidiual components have been specified.

####Setup Requirements
Only Visual Studio 2012 is supported at this time.

##Usage
First please read the [Wiki](https://github.com/liamjbennett/puppet-visualstudio/wiki) regarding how we assume your network
share should be configured. Then installing visualstudio is as simple as:

    visualstudio { "visual studio":
      ensure      => present,
      version     => '2012',
      edition     => 'Professional',
      license_key => 'XXX-XXX-XXX-XXX-XXX',
    }


##Reference
Some basic information, for more read the [Wiki](https://github.com/liamjbennett/puppet-visualstudio/wiki)

###Defintions:

visualstudio::package     - the core visual studio installation <br/>


##Limitations
Support for only 2012 <br/>


##Development
Copyright (C) 2013 Liam Bennett - <liamjbennett@gmail.com> <br/>
Distributed under the terms of the Apache 2 license - see LICENSE file for details. <br/>
Further contributions and testing reports are extremely welcome - please submit a pull request or issue on [GitHub](https://github.com/liamjbennett/puppet-visualstudio) <br/>
Please read the [Wiki](https://github.com/liamjbennett/puppet-visualstudio/wiki) as there is a lot of useful information and links that will help you understand this module <br/>


##Release Notes

__0.0.1__ <br/>
The initial version
