#
# Defined type to set custom facts via a facter.d snippet.
# https://docs.puppetlabs.com/guides/custom_facts.html
#
# BUGS:
#   $facts_directory is not set correctly for Puppet Enterprise or MS Windows
# TODO:
#   Support supplying a source for a facts file.
#
define puppet::fact (
  $value  = undef,
) {

  case $::kernel {
    'Linux': {
      $facts_directory = '/etc/facter/facts.d'
      ensure_resource('file','/etc/facter',{'ensure'=>'directory'})
      ensure_resource('file',$facts_directory,{'ensure'=>'directory'})
    }
    default: { fail("Unsupported platform: ${::osfamily}") }
  }

  file { "${facts_directory}/${name}":
    mode    => '0555',
    content => "#!/bin/sh\necho${name}=${$value}\n",
  }

}
