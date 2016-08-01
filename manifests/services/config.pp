class tic::services::config {

  require ::tic::services::install

  validate_array($tic::services::params::karaf_features_install)
  #validate_re($tic::services::params::ams_syncope_url, $tic::url_re, "syncope url is not valid url. ${tic::services::params::ams_syncope_url}")

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::services::features::install { $tic::services::params::karaf_features_install: }

  if $tic::services::params::karaf_service_ensure == 'running' {
      #Ini_setting { notify => Service['rt-infra-service'] }
  }

  if $tic::services::params::activemq_nodes_count >= $tic::services::params::min_activemq_brokers {
    tic::ini_settings { 'eventsource.amq':
      path     => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
      settings => {
        'activemq.broker.url'      => $tic::services::params::activemq_broker_url,
        'activemq.broker.username' => $tic::services::params::activemq_broker_username,
        'activemq.broker.password' => $tic::services::params::activemq_broker_password,
      }
    }

    tic::ini_settings { 'eventlogging.collector':
      path     => "${config_dir}/org.talend.eventlogging.collector.jms.cfg",
      settings => {
        'collector.jms.url' => $tic::services::params::activemq_broker_url,
      }
    }
  } else {
    warning("got ${tic::services::params::activemq_nodes_count} activemq nodes, expected ${tic::services::params::min_activemq_brokers}")
  }

  tic::ini_settings { 'karaf.features':
    path     => "${config_dir}/org.apache.karaf.features.cfg",
    settings => {
      'featuresBoot' => $tic::services::params::karaf_boot_features_real,
    }
  }

  tic::ini_settings { 'eventlogging.server':
    path     => "${config_dir}/org.talend.eventlogging.server.cfg",
    settings => {
      'elasticsearch.host' => $tic::services::params::elasticsearch_host,
      'elasticsearch.port' => $tic::services::params::elasticsearch_port,
    }
  }

  tic::ini_settings { 'debug_logging_flow':
    path     => "${config_dir}/org.ops4j.pax.logging.cfg",
    settings => {
      'log4j.logger.org.talend.ipaas' => $tic::services::params::logging_level,
    }
  }

  tic::ini_settings { 'log_amq_messages_flow':
    path     => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
    settings => {
      'log.messages' => $tic::services::params::log_amq_messages,
    }
  }

  tic::ini_settings { 'ams_datasource_credentials':
    path     => "${config_dir}/org.talend.ipaas.rt.ams.datasource.cfg",
    settings => {
      'datasource.servername'   => $tic::services::params::ams_postgres_server,
      'datasource.username'     => 'ams',
      'datasource.databasename' => 'ams',
      'datasource.password'     => $tic::services::params::ams_postgres_password,
    }
  }

  tic::ini_settings { 'ams_core_credentials':
    path     => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
    settings => {
      'mongodb.uri'                 => $tic::services::params::mongo_uri,
      'syncope.service.url'         => $tic::services::params::ams_syncope_url,
      'syncope.admin.password'      => $tic::services::params::ams_syncope_password,
      'mail.config.update.period'   => $tic::services::params::ams_mail_config_update_period,
      'mail.config.password.reset'  => $tic::services::params::ams_mail_config_password_reset,
      'mail.config.user.created'    => $tic::services::params::ams_mail_config_user_created,
      'password.reset.url.template' => $tic::services::params::ams_password_reset_url_template,
      'current.region'              => $tic::services::params::ams_current_region,
      'disaster.region'             => $tic::services::params::ams_disaster_region,
    }
  }

  ini_setting { 'ams_mongo_replica_set_option':
    ensure  => $tic::services::params::ams_mongo_replica_set_option,
    path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
    section => '',
    setting => 'mongodb.options.replicaset',
    value   => 'tipaas'
  }

}
