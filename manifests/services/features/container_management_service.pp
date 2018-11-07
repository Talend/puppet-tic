class tic::services::features::container_management_service {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.cms.datasource.cfg":
    settings => {
      'datasource.servername'   => $tic::services::params::cms_db_host,
      'datasource.databasename' => 'cms',
      'datasource.username'     => 'cms',
      'datasource.password'     => $tic::services::params::cms_db_password,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.cms.config.cfg":
    settings => {
      'karaf/org.talend.ipaas.rt.dispatcher.client/dispatcher.input.queue'    => $tic::services::params::dispatcher_input_queue,
      'karaf/org.talend.ipaas.rt.dispatcher.client/dispatcher.response.queue' => $tic::services::params::dispatcher_response_queue,
      'karaf/org.talend.ipaas.rt.dts.client/dts.service.url'                  => $tic::services::params::cms_dts_service_url,
      'karaf/org.talend.ipaas.rt.lts.client/log.transfer.upload.url'          => $tic::services::params::cms_lts_service_url,
      'karaf/org.talend.ipaas.rt.eventsource.amq/activemq.broker.url'         => $tic::services::params::cms_amq_broker_url,
      'karaf/org.talend.eventlogging.sender.jms/sender.destination.jms.url'       => $tic::services::params::cms_amq_broker_url_log,
      'karaf/org.ops4j.pax.url.mvn/org.ops4j.pax.url.mvn.repositories'        => $tic::services::params::cms_nexus_url,
    }
  }

}
