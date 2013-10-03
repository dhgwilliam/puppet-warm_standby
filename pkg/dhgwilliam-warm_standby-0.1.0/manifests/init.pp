class warm_standby {
  include stdlib::stages

  $remote_host = hiera('warm_standby::remote_host')

  package { 'rsync':
    ensure => installed,
  }

  warm_standby::replicate::database { ['console', 'console_auth', 'pe-postgres']:
    remote_host => $remote_host,
  }
  warm_standby::replicate::folder { ['/etc/puppetlabs','/opt/puppet']:
    remote_host => $remote_host,
  }
}
