define warm_standby::replicate::folder (
  $folder = $name,
  $remote_host,
  $ssh_identity = '/root/.ssh/vagrant',
  $exceptions = [],
) {
  $real_exceptions = inline_template('<%= @exceptions.collect! { |f| "--exclude #{f}" } ; @exceptions.join %>')
  exec { "rsync ${folder}":
    command => "/usr/bin/rsync -e 'ssh -i ${ssh_identity}' -avz ${real_exceptions} ${folder}/ ${remote_host}:${folder}",
    require => Package['rsync'],
  }
}
