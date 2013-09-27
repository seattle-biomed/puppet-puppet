# == Class: puppet::package
#
# This class installes the puppet package.
#
# === Parameters
#
# See README.md
#
# === Authors
#
# Atom Powers <atom.powers@seattlebiomed.org>
#
class puppet::package (
  $ensure       = $puppet::package_ensure,
  $package_name = $puppet::params::package_name,
) inherits puppet::params {

  validate_string($ensure, $package_name)

  package { 'puppet':
    name    => $package_name,
    ensure  => $ensure
  }

}
