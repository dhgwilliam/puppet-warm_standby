class warm_standby (
  $remote_host,
  $databases = ['console', 'console_auth', 'pe-postgres', 'pe-puppetdb'],
  $folders = ['/etc/puppetlabs','/opt/puppet'],
) {
  include stdlib::stages

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
