define warm_standby::replicate::folder (
  $folder = $name,
  $remote_host,
  $ssh_identity = '/root/.ssh/id_rsa',
  $exceptions = [],
  $remote_staging = nil,
  $remote_user = $::id,
) {
  $real_exceptions = inline_template('<%= @exceptions.collect! { |f| "--exclude #{f}" } ; @exceptions.join %>')
  exec { "create remote backup folder - ${folder}":
    path    => '/usr/bin',
    command => "ssh -i ${ssh_identity} ${remote_user}@${remote_host} mkdir -p ${remote_staging}${folder}",
    require => Package['rsync'],
  } ->
  exec { "rsync ${folder}":
    path    => '/usr/bin',
    command => "rsync -e 'ssh -i ${ssh_identity}' -avz ${real_exceptions} ${folder}/ $remote_user@${remote_host}:${remote_staging}${folder}",
    require => Package['rsync'],
  }
}
