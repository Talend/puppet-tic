class tic::frontend::dd_user {

  user {'mod_datadog_user':
    name   => 'dd-agent',
    groups => 'adm',
  }

}
