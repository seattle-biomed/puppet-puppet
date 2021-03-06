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
  $package_name       = 'puppet',
  $package_ensure     = 'installed',
  $service_ensure     = 'running',
  $service_enable     = true,
  $config_options     = {},
  $sysconfig_options  = {},
) {

  anchor { '::puppet::start': } ->
  class { '::puppet::package': } ->
  class { '::puppet::config':  } ~>
  class { '::puppet::service': } ->
  anchor { '::puppet::end': }

}
