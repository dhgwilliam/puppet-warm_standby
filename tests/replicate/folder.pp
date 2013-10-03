warm_standby::replicate::folder { '/etc/puppetlabs':
  remote_host => 'puppet2.puppetlabs.com',
  exceptions  => ['**var/lib/pgsql**'],
}
