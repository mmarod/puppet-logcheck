# Logcheck

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with Logcheck](#setup)
    * [What Logcheck affects](#what-Logcheck-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with Logcheck](#beginning-with-Logcheck)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

## Overview

The Logcheck module installs and configures the Logcheck service.

## Module Description

Logcheck is a simple utility which is designed to allow a system administrator to view
the logfiles which are produced upon hosts under their control. It does this by
mailing summaries of the logfiles to them, after first filtering out "normal" entries.
Normal entries are entries which match one of the many included regular expression
files contain in the database.

This module installs and configures Logcheck.

## Setup

### What Logcheck affects

* No services should be affected by Logcheck

### Setup requirements

* Puppet-3.0.0 or later

### Beginning with Logcheck

include 'logcheck'

## Usage

Use Hiera or directly define class variables

### Hiera

Include the Class

````puppet
include logcheck
```

Hiera Data

````puppet
logcheck::config:
    REPORTLEVEL: server
    SENDMAILTO: logcheck@example.com
    ADDTAG: yes
```

### Define variables explicitly

Include the Class

````puppet
class { 'logcheck':
    config => {
        'REPORTLEVEL'   => 'server',
        'SENDMAILTO'    => 'logcheck@example.com',
        'ADDTAG'        => 'yes'
    }
}
```

## Reference

### Classes

### Public Classes

* [logcheck](#logcheck): The Logcheck class

### `logcheck`

#### Parameters

### `logcheck::config`

The changes to make to the logcheck configuration file. Augeas is used to implement
the changes using the Shellvars lens.

### `logcheck::package`

The name of the logcheck package. Defaults to 'logcheck'

### `logcheck::configfile`

The path to logcheck.conf. Default is /etc/logcheck/logcheck.conf
