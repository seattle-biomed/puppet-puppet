puppet
===

This module manager puppet agent and/or puppetmaster.
It is intended for use in an already installed and functioning puppet environment.

This module is most flexible and most easier to manage when used with hiera.

## Classes

### puppet
This class wraps the individual puppet package, config, and service classes.

#### Parameters
* `package_ensure` - What state the package should be in.
Valid values are `present`, `installed`, `absent`, `purged`, `held`, `latest`.
Default: `installed`

* `agent_ensure` - Whether a service should be running.
Valid values are `stopped`, `running`.
Defalut: `running`

* `agent_enable` - Whether a service should be enabled to start at boot.
Valid values are `true`, `false`, `manual`.
Default: `true`

* `master_ensure` - Whether a service should be running.
Valid values are `stopped`, `running`.
Defalut: `undef`

* `master_enable` - Whether a service should be enabled to start at boot.
Valid values are `true`, `false`, `manual`.
Default: `false`

* `config_main_options_hash` - A hash of options for the [main] section of puppet.conf
Default: empty

* `config_master_options_hash` - A hash of options for the [master] section of puppet.conf
Default: empty

* `config_agent_options_hash` - A hash of options for the [agent] section of puppet.conf
Default: empty

* `sysconfig_options_hash` - A hash of options for the defaults/sysconfig daemon configuration.
Default: empty

*  `config_file_resources` - A hash of options used to create additional configuration files.
Default: empty


### puppet::package
This class installs puppet from default repositories.
If you wish to add the puppetlabs repository do it in the module that manages apt/yum/etc.

#### Parameters
* `ensure` - What state the package should be in.
Valid values are `present`, `installed`, `absent`, `purged`, `held`, `latest`.
Default: `$puppet::package_ensure`

* `package_name` - The name of the puppet package to install.
Default: from `$puppet::params::package_name`

### puppet::config
This class installs puppet configuration files. The files are empty unless the
*_options_hash variables contain data. (Empty configuration files will cause default
behavior as defined here: http://docs.puppetlabs.com/references/latest/configuration.html )

Additional configuration files, such as `hiera.yaml` and `routes.yaml` can be
included via the `file_resources` parameter.

#### Parameters
* `main_options_hash` - A hash of options for the [main] section of puppet.conf
Default: `$puppet::config_main_options_hash`

* `master_options_hash` - A hash of options for the [master] section of puppet.conf
Default: `$puppet::config_master_options_hash`

* `agent_options_hash` - A hash of options for the [agent] section of puppet.conf
Default: `$puppet::config_agent_options_hash`

* `sysconfig_options_hash` - A hash of options for the defaults/sysconfig daemon configuration.
Default: `$puppet::sysconfig_options_hash`

* `config_file` - The fully qualified path to puppet.conf.
Defalut: from `$puppet::params::config_file`

* `sysconfig_file` - The fully qualified path to the defaults/sysconfig daemon configuration.
Default: from `$puppet::params::sysconfig_file`

*  `file_resources` - A hash of options used to create additional configuration files.
This parameter is used with 'create_resources(file,$file_resources)' and is intended
to manage additional configuration files such as 'hiera.yaml' which are not templates.
Default: `$puppet::config_file_resources`

### puppet::agent::service
This class manages the puppet agent service.
If you want puppet to run via cron then set enable and ensure to false values
and create a cron script in a module that manages cron jobs.

#### Parameters
* `enable` - Whether a service should be enabled to start at boot.
Valid values are `true`, `false`, `manual`.
Default: `$puppet::agent_enable`

* `ensure` - Whether a service should be running.
Valid values are `stopped`, `running`.
Default: `$puppet::agent_ensure`

* `service_name` - The name of the puppet service.
Default: from `$puppet::params::agent_service_name`

### puppet::master::service
This class manages the puppetmaster service.
To run puppet master behind a web server (apache, nginx, etc.) leave the defaults
alone and create a web service for your web server module.

#### Parameters
* `enable` - Whether a service should be enabled to start at boot.
Valid values are `true`, `false`, `manual`.
Default: `$puppet::master_enable`

* `ensure` - Whether a service should be running.
Valid values are `stopped`, `running`.
Default: `$puppet::master_ensure`

* `service_name` - The name of the puppet service.
Default: from `$puppet::params::master_service_name`

## Example
    ---
    classes:
      - puppet

    puppet::config_main_options_hash:
      server:       'puppet.domain.tld'
      environment:  'production'
      confdir:      '/etc/puppet'
      hiera_config: '/etc/puppet/hiera.yaml'

    puppet::config_master_options_hash:
      node_terminus:            'exec'
      external_nodes:           '/etc/puppet/bin/node_role.rb'
      ssl_client_header:        'SSL_CLIENT_S_DN'
      ssl_client_verify_header: 'SSL_CLIENT_VERIFY'

    puppet::config_agent_options_hash:
      pluginsync:   'true'
      report:       'true'
      runinterval:  '1800'
      splay:        'true'
      splaylimit:   '300'

    puppet::config_sysconfig_options_hash:
      START:  'yes'

    puppet::config_file_resources:
      '/etc/puppet/hiera.yaml':
        source: 'puppet:///files/puppet/hiera.yaml'

## Authors
* Atom Powers <atom.powers@seattlebiomed.org>

