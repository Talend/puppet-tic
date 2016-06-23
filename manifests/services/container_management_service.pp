class tic::services::container_management_service {
  $config_dir = $tic::services::config::config_dir

  tic::ini_settings { 'container_management_service_datasource':
    path     => "${config_dir}/org.talend.ipaas.rt.cms.datasource.cfg",
    settings => {
      'datasource.servername'   => $tic::cms_db_host,
      'datasource.databasename' => 'cms',
      'datasource.username'     => 'cms',
      'datasource.password'     => $tic::cms_db_password,
    }
  }

  tic::ini_settings { 'container_management_service_config':
    path     => "${config_dir}/org.talend.ipaas.rt.cms.config.cfg",
    settings => {
      'karaf/org.talend.ipaas.rt.dispatcher.client/dispatcher.input.queue'    => "ipaas.${tic::subenv_prefix}.dispatcher.input.queue",
      'karaf/org.talend.ipaas.rt.dispatcher.client/dispatcher.response.queue' => "ipaas.${tic::subenv_prefix}.dispatcher.response.queue",
      'karaf/org.talend.ipaas.rt.dts.client/dts.service.url'                  => $tic::cms_dts_service_url,
      'karaf/org.talend.ipaas.rt.eventsource.amq/activemq.broker.url'         => $tic::cms_amq_broker_url,
      'karaf/org.ops4j.pax.url.mvn/org.ops4j.pax.url.mvn.repositories'        => $tic::cms_nexus_url,
    }
  }
}
