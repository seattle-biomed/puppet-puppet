# == Class: puppet::params
#
# Default values for various puppet classes.
#
# === Parameters
#
# None.
#
# === Authors
#
# Atom Powers <atom.powers@seattlebiomed.org>
#
class puppet::params {

## Package Defaults
  case $::osfamily {
    'Debian': {
      $package_name = 'puppet'
    }
    'RedHat': {
      $package_name = 'puppet'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

## Config Defaults
  $config_file   = '/etc/puppet/puppet.conf'

## Service Defaults
  case $::osfamily {
    'Debian': {
      $agent_service_name   = 'puppet'
      $master_service_name  = 'puppetmaster'
      $sysconfig_file       = '/etc/default/puppet'
    }
    'RedHat': {
      $agent_service_name   = 'puppet'
      $master_service_name  = 'puppetmaster'
      $sysconfig_file       = '/etc/sysconfig/puppet'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }



}
