class warm_standby (
  $remote_host,
  $ssh_identity      = undef,
  $databases         = ['console', 'console_auth', 'pe-postgres', 'pe-puppetdb'],
  $replicate_folders = true,
  $folders           = ['/etc/puppetlabs','/opt/puppet'],
) {
  include stdlib::stages

  package { 'rsync':
    ensure => installed,
  }

  warm_standby::replicate::database { $databases:
    remote_host  => $remote_host,
    ssh_identity => $ssh_identity,
    require      => Package['rsync'],
  }

  if $replicate_folders {
    warm_standby::replicate::folder { $folders:
      remote_host  => $remote_host,
      ssh_identity => $ssh_identity,
      require      => Package['rsync'],
    }
  }
}
