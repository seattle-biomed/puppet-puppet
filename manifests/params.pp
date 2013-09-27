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
    RedHat: {
      $package_name = 'puppet'
    }
    Debian: {
      $package_name = 'puppet'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

## Config Defaults
  $config_file   = '/etc/puppet/puppet.conf'

## Service Defaults
  case $::operatingsystem {
    Ubuntu: {
      $agent_service_name   = 'puppet'
      $master_service_name  = 'puppetmaster'
      $sysconfig_file       = '/etc/default/puppet'
    }
    Fedora: {
      $agent_service_name   = 'puppetagent'
      $master_service_name  = 'puppetmaster'
      $sysconfig_file       = '/etc/sysconfig/puppetagent'
    }
    CentOS, RedHat: {
      $agent_service_name   = 'puppet'
      $master_service_name  = 'puppetmaster'
      $sysconfig_file       = '/etc/sysconfig/puppet'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }



}
