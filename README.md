# puppet-visualstudio

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What is the visualstudio module?](#module-description)
3. [Setup - The basics of getting started with visualstudio](#setup)
    * [What visualstudio affects](#what-visualstudio-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with visualstudio](#beginning-with-visualstudio)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

Puppet module for managing [Microsoft Visual Studio](http://www.visualstudio.com/)

[![Build Status](https://secure.travis-ci.org/liamjbennett/puppet-visualstudio.png)](http://travis-ci.org/liamjbennett/puppet-visualstudio)

##Module Description

The purpose of this module is to install the Microsoft Visual Studio suite and configure it's many service packs, tools, utilities and registry options.

##Setup

###What autoupdates affects

$$$$

###Beginning with autoupdate

Installing Visual Studio 2012:

```puppet
    visualstudio { "visual studio":
      ensure      => present,
      version     => '2012',
      edition     => 'Professional',
      license_key => 'XXX-XXX-XXX-XXX-XXX',
    }
```

##Usage

###Classes and Defined Types

####Defined Type: `visualstudio`
The primary definition of this module, it installs and configures the visual studio application on the system

**Parameters within `visualstudio`:**
#####`ensure`
Ensure that the application is installed or not.

#####`version`
The version of visual studio that should be installed

#####`edition`
The edition of visual studio that should be installed

#####`license_key`
The license key that corresponds to the version and edition that you have specified. This is required for installation to be successful.

#####`components`
The list components, tools and utilities that can be installed as part of the visual studio installation.

##Reference

###Defined Types
####Public Defined Types
* [`visualstudio`](#class_visualstudio): Guides the basic installation and configuration of visual studio


##Limitations

This module is tested on the following platforms:

* Windows 2008 R2

It is tested with the OSS version of Puppet only.

It support the following Visual Studio versions:

* 2012

##Development

###Contributing

Please read CONTRIBUTING.md for full details on contributing to this project.
