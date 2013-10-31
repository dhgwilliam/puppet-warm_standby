class warm_standby {
  include stdlib::stages

  $remote_host = hiera('warm_standby::remote_host')
  $databases = hiera(
    'warm_standby::databases',
    ['console', 'console_auth', 'pe-postgres']
  )
  $folders = hiera(
    'warm_standby::folders',
    ['/etc/puppetlabs','/opt/puppet']
  )

  package { 'rsync':
    ensure => installed,
  }

  warm_standby::replicate::database { $databases:
    remote_host => $remote_host,
    require     => Package['rsync'],
  }

  warm_standby::replicate::folder { $folders:
    remote_host => $remote_host,
    require     => Package['rsync'],
  }

}
