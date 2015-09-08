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
class puppet::server (
  $package_name       = 'puppetserver',
  $package_ensure     = 'installed',
  $service_enable     = true,
  $service_ensure     = 'running',
  $config_options     = {'environmentpath' => '$confdir/environments',},
  $sysconfig_options  = {},
) {

  anchor { '::puppet::server::start': } ->
  class { '::puppet::server::package': } ->
  class { '::puppet::server::config': } ~>
  class { '::puppet::server::service': } ->
  anchor { '::puppet::server::end': }

}
