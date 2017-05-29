class tic::services::config {

  require ::tic::services::install

  validate_array($tic::services::params::karaf_features_install)

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  $features = unique($tic::services::params::karaf_features_install)
  tic::services::features::install { $features: }

  if $tic::services::params::activemq_nodes_count >= $tic::services::params::min_activemq_brokers {
    tic::ini_settings { 'eventsource.amq':
      path     => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
      settings => {
        'activemq.broker.url'      => $tic::services::params::activemq_broker_url,
        'activemq.broker.username' => $tic::services::params::activemq_broker_username,
        'activemq.broker.password' => $tic::services::params::activemq_broker_password,
      }
    }

    tic::ini_settings { "${config_dir}/org.talend.eventlogging.collector.jms.cfg":
      settings => {
        'collector.jms.url'      => $tic::services::params::activemq_broker_url,
        'collector.jms.username' => $tic::services::params::activemq_broker_username,
        'collector.jms.password' => $tic::services::params::activemq_broker_password,
      }
    }
  } else {
    warning("got ${tic::services::params::activemq_nodes_count} activemq nodes, expected ${tic::services::params::min_activemq_brokers}")
  }

  $features20 = hiera('tic::services20::karaf_features_install', [])
  $features_all = concat($tic::services::params::karaf_features_install, $features20)
  $features_all_str = join($features_all, ',')

  tic::ini_settings { "${config_dir}/org.apache.karaf.features.cfg":
    settings => {
      'featuresBoot' => $features_all_str,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.eventlogging.server.cfg":
    settings => {
      'elasticsearch.host' => $tic::services::params::elasticsearch_host,
      'elasticsearch.port' => $tic::services::params::elasticsearch_port,
    }
  }

  tic::ini_settings { "${config_dir}/org.ops4j.pax.logging.cfg":
    settings => {
      'log4j.logger.org.talend.ipaas' => $tic::services::params::logging_level,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg":
    settings => {
      'log.messages' => $tic::services::params::log_amq_messages,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.ams.datasource.cfg":
    settings => {
      'datasource.servername'   => $tic::services::params::ams_postgres_server,
      'datasource.username'     => 'ams',
      'datasource.databasename' => 'ams',
      'datasource.password'     => $tic::services::params::ams_postgres_password,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.ams.core.cfg":
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

  tic::ini_settings { "${config_dir}/org.ops4j.pax.web.cfg":
    settings => {
      'org.osgi.service.http.port' => $tic::services::params::osgi_http_service_port,
    }
  }

}
