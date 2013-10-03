class warm_standby::services (
  $remote_host = hiera('warm_standby::remote_host'),
  $action,
) {
  # XXX validate $action
  Warm_standby::Remote_service {
    remote_host => $remote_host,
    action      => $action,
  }

  if $action == 'stop' {
    Sleep { bedtime => '0', }
  } else {
    Sleep { bedtime => '30', }
  }


  warm_standby::remote_service { "${action} pe-httpd":
    service => "pe-httpd",
  }
  -> warm_standby::remote_service { "${action} pe-activemq":
    service => "pe-activemq",
  }
  -> sleep { 'a': }
  -> warm_standby::remote_service { "${action} pe-mcollective":
    service => "pe-mcollective",
  }
  -> warm_standby::remote_service { "${action} pe-postgresql":
    service => "pe-postgresql",
  }
  -> sleep { 'b': }
  -> sleep { 'c': }
  -> warm_standby::remote_service { "${action} pe-puppetdb":
    service => "pe-puppetdb",
  }
  -> warm_standby::remote_service { "${action} pe-puppet-dashboard-workers":
    service => "pe-puppet-dashboard-workers",
  }
}
