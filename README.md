# Visual Studio module for Puppet

[![Build Status](https://travis-ci.org/voxpupuli/puppet-visualstudio.png?branch=master)](https://travis-ci.org/voxpupuli/puppet-visualstudio)
[![Code Coverage](https://coveralls.io/repos/github/voxpupuli/puppet-visualstudio/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet-visualstudio)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/visualstudio.svg)](https://forge.puppetlabs.com/puppet/visualstudio)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/visualstudio.svg)](https://forge.puppetlabs.com/puppet/visualstudio)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/visualstudio.svg)](https://forge.puppetlabs.com/puppet/visualstudio)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/visualstudio.svg)](https://forge.puppetlabs.com/puppet/visualstudio)

**The module is deprecated, please reach out to the Vox Pupuli mailinglist at voxpupuli@groups.io if you're still using it**

#### Table of Contents

1. [Overview](#overview)
1. [Module Description - What is the visualstudio module?](#module-description)
1. [Setup - The basics of getting started with visualstudio](#setup)
    * [What visualstudio affects](#what-visualstudio-affects)
    * [Beginning with visualstudio](#beginning-with-visualstudio)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Overview

Puppet module for managing [Microsoft Visual Studio](http://www.visualstudio.com/)

[![Build Status](https://secure.travis-ci.org/liamjbennett/puppet-visualstudio.png)](http://travis-ci.org/liamjbennett/puppet-visualstudio)

## Module Description

The purpose of this module is to install the Microsoft Visual Studio suite and
configure it's many service packs, tools, utilities and registry options.

## Setup

### What autoupdates affects

* Installs packages
* Alters registry keys

### Beginning with autoupdate

Installing Visual Studio 2012:

```puppet
    visualstudio { "visual studio":
      ensure      => present,
      version     => '2012',
      edition     => 'Professional',
      license_key => 'XXX-XXX-XXX-XXX-XXX',
    }
```

## Usage

### Classes and Defined Types

#### Defined Type: `visualstudio`

The primary definition of this module, it installs and configures the visual
studio application on the system

**Parameters within `visualstudio`:**

##### `ensure`

Ensure that the application is installed or not.

##### `version`

The version of visual studio that should be installed

##### `edition`

The edition of visual studio that should be installed

##### `license_key`

The license key that corresponds to the version and edition that you have
specified. This is required for installation to be successful.

##### `components`

The list components, tools and utilities that can be installed as part of the
visual studio installation.

##### `deployment_root`

Network location where the visual studio packages are located

## Reference

### Defined Types

#### Public Defined Types

* [`visualstudio`](#class_visualstudio): Guides the basic installation and
  configuration of visual studio

## Limitations

This module is tested on the following platforms:

* Windows 2008 R2

It is tested with the OSS version of Puppet only.

It support the following Visual Studio versions:

* 2012

## Development

### Contributing

Please read CONTRIBUTING.md for full details on contributing to this project.
