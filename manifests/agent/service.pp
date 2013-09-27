# == Class: puppet::agent::service
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
class puppet::agent::service (
  $enable         = $puppet::agent_enable,
  $ensure         = $puppet::agent_ensure,
  $service_name   = $puppet::params::agent_service_name,
) inherits puppet::params {

  validate_string($ensure,$service_name)
  validate_bool($enable)

  service { 'puppet':
    name       => $service_name,
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => Class['puppet::config'],
  }

}
