# == Class: puppet
#
# This class installs the puppet package, configuration, and agent using
# common sense defaults. Sub-classes can be individually configured using
# hiera.
#
# Validations are don in the sub-classes where heira values are imported.
#
# === Parameters
#
# See README.md
#
# === Authors
#
# Atom Powers <atom.powers@seattlebiomed.org>
#
class puppet (
  $package_ensure             = 'installed',
  $agent_ensure               = 'running',
  $agent_enable               = true,
  $master_ensure              = undef,
  $master_enable              = false,
  $config_main_options_hash   = hash([]),
  $config_master_options_hash = hash([]),
  $config_agent_options_hash  = hash([]),
  $sysconfig_options_hash     = hash([]),
  $config_file_resources      = hash([]),
  $package_resources          = hash([]),
) {

  class { 'puppet::package':
    ensure    => $package_ensure,
    packages  => $package_resources,
  } ->
  class { 'puppet::config':
    main_options_hash       => $config_main_options_hash,
    master_options_hash     => $config_master_options_hash,
    agent_options_hash      => $config_agent_options_hash,
    sysconfig_options_hash  => $sysconfig_options_hash,
    file_resources          => $config_file_resources,
  }

  if ( $agent_ensure ) {
    class { 'puppet::agent::service':
      enable    => $agent_enable,
      ensure    => $agent_ensure,
      subscribe => Class['puppet::config']
    }
  }

  if ( $master_ensure ) {
    class { 'puppet::master::service':
      enable    => $master_enable,
      ensure    => $master_ensure,
      subscribe => Class['puppet::config']
    }
  }
}
