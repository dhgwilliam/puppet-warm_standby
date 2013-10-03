define warm_standby::replicate::database (
  $database             = $name,
  $remote_host,
  $remote_user          = 'root',
  $ssh_identity         = '/root/.ssh/vagrant',
  $remote_staging_area  = '/tmp',
  $local_staging_area   = '/tmp',
  $backup_user          = 'pe-postgres',
) {
  if $ssh_identity {
    $real_identity = "-i ${ssh_identity}"
  } else { $real_identity = '' }

  exec { "dump ${database} command":
    path    => '/opt/puppet/bin',
    command => "pg_dump -Z 9 -Fc ${database} > ${local_staging_area}/${database}.dump",
    user    => $backup_user,
  } ->
  exec { "rsync ${database} to ${remote_host}":
    path    => '/usr/bin',
    command => "rsync -e 'ssh ${real_identity}' -avz ${local_staging_area}/${database}.dump ${remote_host}:${remote_staging_area}",
  } ->
  exec { "remote restore of ${database}":
    path    => '/usr/bin',
    command => "ssh ${real_identity} ${remote_user}@${remote_host} 'sudo -u pe-postgres /opt/puppet/bin/pg_restore -c --jobs=2 -Fc ${remote_staging_area}/${database}.dump'",
  }
}
