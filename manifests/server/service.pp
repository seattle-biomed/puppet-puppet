# == Class: puppet::server::service
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
class puppet::server::service (
  $enable         = $puppet::server::service_enable,
  $ensure         = $puppet::server::service_ensure,
  $service_name   = 'puppetserver',
) inherits puppet::params {

  validate_string($ensure,$service_name)
  validate_bool($enable)

  service { 'puppetserver':
    ensure     => $ensure,
    name       => $service_name,
    enable     => $enable,
    subscribe  => Class['puppet::config'],
  }

}
