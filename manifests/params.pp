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

## Config Defaults
  $config_file   = '/etc/puppet/puppet.conf'

## Service Defaults
  case $::osfamily {
    'Debian': {
      $master_service_name    = 'puppetmaster'
      $sysconfig_file         = '/etc/default/puppet'
      $server_sysconfig_file  = '/etc/default/puppetserver'
    }
    'RedHat': {
      $master_service_name    = 'puppetmaster'
      $sysconfig_file         = '/etc/sysconfig/puppet'
      $server_sysconfig_file  = '/etc/sysconfig/puppetserver'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

  $default_sysconfig_options = {
    'START' => 'yes'
  }

  $default_server_sysconfig_options = {
    'JAVA_BIN'              => '/usr/bin/java',
    'JAVA_ARGS'             => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
    'USER'                  => 'puppet',
    'INSTALL_DIR'           => '/usr/share/puppetserver',
    'CONFIG'                => '/etc/puppetserver/conf.d',
    'BOOTSTRAP_CONFIG'      => '/etc/puppetserver/bootstrap.cfg',
    'SERVICE_STOP_RETRIES'  => '60',
  }

}
