# == Class: puppet::master::service
#
# This class starts the puppet agent service.
# It should not be declared except through the parent class.
#
# === Parameters
#
# See README.md
#
# === Authors
#
# Atom Powers <atom.powers@seattlebiomed.org>
#
class puppet::master::service (
  $enable         = $puppet::master_enable,
  $ensure         = $puppet::master_ensure,
  $service_name   = $puppet::params::master_service_name,
) inherits puppet::params {

  validate_string($ensure,$service_name)
  validate_bool($enable)

  service { 'puppetmaster':
    name       => $master_service_name,
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => Class['puppet::config'],
  }

}
