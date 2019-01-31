class tic::services::config {

  require ::tic::services::install

  validate_array($tic::services::params::karaf_features_install)

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  $features = unique($tic::services::params::karaf_features_install)

  tic::services::features::install { $features: }

  tic::ini_settings {

    'iam_scim_client':
      path     => "${config_dir}/org.talend.ipaas.rt.iam.scim.client.cfg",
      settings => {
        'iam.service.url'  => $tic::services::params::iam_service_url,
        'scim.service.url' => $tic::services::params::scim_service_url,
      };

    'karaf_features':
      path     => "${config_dir}/org.apache.karaf.features.cfg",
      settings => {
        'featuresBoot' => join($features, ','),
      };

    'eventlogging_server':
      path     => "${config_dir}/org.talend.eventlogging.server.cfg",
      settings => {
        'elasticsearch.host' => $tic::services::params::elasticsearch_host,
        'elasticsearch.port' => $tic::services::params::elasticsearch_port,
      };

    'log4j_configuration':
      path     => "${config_dir}/org.ops4j.pax.logging.cfg",
      settings => {
        'log4j2.logger.ipaas.name'  => 'org.talend.ipaas',
        'log4j2.logger.ipaas.level' => $tic::services::params::logging_level,
      };

    'eventsource_amq':
      path     => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
      settings => {
        'log.messages' => $tic::services::params::log_amq_messages,
      };

    'ams_datasource':
      path     => "${config_dir}/org.talend.ipaas.rt.ams.datasource.cfg",
      settings => {
        'datasource.servername'   => $tic::services::params::ams_postgres_server,
        'datasource.username'     => 'ams',
        'datasource.databasename' => 'ams',
        'datasource.password'     => $tic::services::params::ams_postgres_password,
      };

    'ams_core':
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
        'amq_security'                => $tic::services::params::amq_security_switch,
      };

    'ams_mongo_replica_set_option':
      path     => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      settings =>  {
        'mongodb.options.replicaset' => 'tipaas',
      };

    'pax_web':
      path     => "${config_dir}/org.ops4j.pax.web.cfg",
      settings => {
        'org.osgi.service.http.port' => $tic::services::params::osgi_http_service_port,
      };

    'ensuring minConnectionsPerHost':
      path     => "${config_dir}/org.talend.ipaas.rt.mongo.common.cfg",
      settings => {
        'minConnectionsPerHost' => '0',
      };

    'zipkin':
      path     => "${config_dir}/org.talend.ipaas.rt.zipkin.cfg",
      settings => {
        'zipkin.enabled'                => $tic::services::params::zipkin_enabled,
        'zipkin.kafka.topic'            => $tic::services::params::zipkin_kafka_topic,
        'zipkin.kafka.bootstrapServers' => $tic::services::params::zipkin_kafka_servers,
        'zipkin.sampler.percentage'     => $tic::services::params::zipkin_sampling_rate,
      };

    'cms_service':
      path     => "${config_dir}/org.talend.ipaas.rt.cms.cfg",
      settings => {
        'license-management.url' => $tic::services::params::license_service_url,
        'vault.url'              => $tic::services::params::vault_url,
        'vault.ipaas.role.id'    => $tic::services::params::ipaas_role_id,
        'vault.ipaas.secret.id'  => $tic::services::params::ipaas_secret_id,
      };

  }

  if 'tipaas-tpsvc-crypto-client' in $features {
    tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.tpsvc.crypto.client.cfg":
      settings => {
        'crypto.tpsvc.service.url' => $tic::services::params::crypto_service_url
      }
    }
  }

  if 'tpsvc-config-client' in $features {
    tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.tpsvc.config.client.cfg":
      settings => {
        'config.service.url' => $tic::services::params::config_service_url
      }
    }
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

}
