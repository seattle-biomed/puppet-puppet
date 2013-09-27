# == Class: puppet::agent
#
# This class configures puppet.
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
class puppet::config (
  $main_options_hash      = $puppet::config_main_options_hash,
  $agent_options_hash     = $puppet::config_agent_options_hash,
  $master_options_hash    = $puppet::config_master_options_hash,
  $sysconfig_options_hash = $puppet::config_sysconfig_options_hash,
  $file_resources         = $puppet::config_file_resources,
  $config_file            = $puppet::params::config_file,
  $sysconfig_file         = $puppet::params::sysconfig_file,
) inherits puppet::params {

  validate_hash($main_options_hash)
  validate_hash($agent_options_hash)
  validate_hash($master_options_hash)
  validate_hash($sysconfig_options_hash)
  validate_absolute_path($config_file, $sysconfig_file)

  file { 'puppet_config_file':
    path    => $config_file,
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('puppet/puppet.conf.erb'),
    require => Class['puppet::package'],
  }

  file { 'puppet_sysconfig_file':
    path    => $sysconfig_file,
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/sysconfig.erb'),
    require => Class['puppet::package'],
  }

  $file_resource_defaults = {
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  create_resources('file',$file_resources,$file_resource_defaults)

}
