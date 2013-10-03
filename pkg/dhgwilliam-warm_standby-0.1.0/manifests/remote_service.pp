define warm_standby::remote_service (
  $service = $name,
  $remote_host = hiera('warm_standby::remote_host'),
  $remote_user  = 'root',
  $ssh_identity = '/root/.ssh/vagrant',
  $action       = 'restart',
) {
  if $ssh_identity {
    $real_identity = "-i ${ssh_identity}"
  } else { $real_identity = '' }

  exec { "${action} remote service ${service}":
    path    => '/usr/bin',
    command => "ssh ${real_identity} ${remote_user}@${remote_host} '/etc/init.d/${service} ${action}'",
  }
}
