class tic::services::config {

  $config_dir = "${tic::karaf_base_path}/etc"

  if $tic::karaf_service_ensure == 'running' {
      Ini_setting { notify => Service['rt-infra-service'] }
  }

  # include one class per feature
  if 'tipaas-bookkeeper-service' in $tic::karaf_features_install {
    contain 'tic::services::bookkeeper_service'
  }

  if 'tipaas-crypto-service-client' in $tic::karaf_features_install {
    contain 'tic::services::crypto_service_client'
  }

  if 'tipaas-crypto-service-core' in $tic::karaf_features_install {
    contain 'tic::services::crypto_service'
  }

  if 'tipaas-bookkeeper-client' in $tic::karaf_features_install {
    contain 'tic::services::bookkeeper_client'
  }

  if 'tipaas-dispatcher-core' in $tic::karaf_features_install {
    contain 'tic::services::dispatcher'
  }

  if 'tipaas-data-transfer-service-core' in $tic::karaf_features_install {
    contain 'tic::services::data_transfer_service'
  }

  if 'tipaas-data-transfer-service-client' in $tic::karaf_features_install {
    contain 'tic::services::data_transfer_service_client'
  }

  if 'tipaas-dispatcher-client' in $tic::karaf_features_install {
    contain 'tic::services::dispatcher_client'
  }

  if 'tipaas-flow-manager-service' in $tic::karaf_features_install {
    contain 'tic::services::flow_manager'
  }

  if 'tipaas-flow-manager-client' in $tic::karaf_features_install {
    contain 'tic::services::flow_manager_client'
  }

  if 'tipaas-scheduler' in $tic::karaf_features_install {
    contain 'tic::services::scheduler'
  }

  if 'tipaas-scheduler-client' in $tic::karaf_features_install {
    contain 'tic::services::scheduler_client'
  }

  if 'tipaas-account-manager-client' in $tic::karaf_features_install {
    contain 'tic::services::account_manager_client'
  }

  if 'tipaas-artifact-manager-client-runtime' in $tic::karaf_features_install {
    contain 'tic::services::artifact_manager_client'
  }

  if 'tipaas-artifact-manager-service' in $tic::karaf_features_install {
    contain 'tic::services::artifact_manager_service'
  }

  if 'tipaas-container-management-service' in $tic::karaf_features_install {
    contain 'tic::services::container_management_service'
  }

  if 'tipaas-container-management-service-client' in $tic::karaf_features_install {
    contain 'tic::services::container_management_service_client'
  }

  if 'tipaas-configuration-service-core' in $tic::karaf_features_install {
    contain 'tic::services::configuration_management_service'
  }

  if 'tipaas-configuration-service-client' in $tic::karaf_features_install {
    contain 'tic::services::configuration_management_service_client'
  }

  if 'tipaas-schema-discovery-service-core' in $tic::karaf_features_install {
    contain 'tic::services::schema_discovery_service'
  }

  if 'tipaas-trial-registration-service' in $tic::karaf_features_install {
    contain 'tic::services::trial_registration_service'
  }

  if 'tipaas-plan-executor-service' in $tic::karaf_features_install {
    contain 'tic::services::plan_execution_service'
  }

  if 'tipaas-plan-executor-client' in $tic::karaf_features_install {
    contain 'tic::services::plan_execution_client'
  }

  if 'tipaas-custom-resources-service' in $tic::karaf_features_install {
    contain 'tic::services::custom_resources_service'
  }

  if 'tipaas-webhooks-service' in $tic::karaf_features_install {
    contain 'tic::services::webhooks_service'
  }

  if 'tipaas-notification-subscription-service' in $tic::karaf_features_install {
    contain 'tic::services::notification_subscription_service'
  }

  if 'tipaas-notification-manager' in $tic::karaf_features_install {
    contain 'tic::services::notification_manager'
  }

  if 'tipaas-notification-server' in $tic::karaf_features_install {
    contain 'tic::services::notification_server'
  }

  if 'tipaas-notification-client' in $tic::karaf_features_install {
    contain 'tic::services::notification_client'
  }

  #FIXME: handle activemq_broker_url and activemq_broker_url_eventlogging separately
  if $tic::activemq_nodes_count >= $tic::min_activemq_brokers {

      ini_setting {
        'activemq_broker_url':
          ensure  => present,
          path    => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
          section => '',
          setting => 'activemq.broker.url',
          value   => $tic::activemq_broker_url;

        'activemq_broker_username':
          ensure  => present,
          path    => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
          section => '',
          setting => 'activemq.broker.username',
          value   => 'tadmin';

        'activemq_broker_password':
          ensure  => present,
          path    => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
          section => '',
          setting => 'activemq.broker.password',
          value   => 'tadmin';

        'activemq_broker_url_eventlogging':
          ensure  => present,
          path    => "${config_dir}/org.talend.eventlogging.collector.jms.cfg",
          section => '',
          setting => 'collector.jms.url',
          value   => $tic::activemq_broker_url;
      }

  } else {
    warning("got ${tic::activemq_nodes_count} activemq nodes, expected ${tic::min_activemq_brokers}")
  }

  validate_re($tic::ams_syncope_url, $tic::url_re, "syncope  url is not valid url. ${tic::ams_syncope_url}")

  ini_setting {

    'karaf_featuresBoot':
      ensure  => present,
      path    => "${config_dir}/org.apache.karaf.features.cfg",
      section => '',
      setting => 'featuresBoot',
      value   => $tic::karaf_boot_features_real;

    'elasticsearch_host':
      ensure  => present,
      path    => "${config_dir}/org.talend.eventlogging.server.cfg",
      section => '',
      setting => 'elasticsearch.host',
      value   => $tic::elasticsearch_host;

    'elasticsearch_port':
      ensure  => present,
      path    => "${config_dir}/org.talend.eventlogging.server.cfg",
      section => '',
      setting => 'elasticsearch.port',
      value   => $tic::elasticsearch_port;

    'debug_logging_flow':
      ensure  => present,
      path    => "${config_dir}/org.ops4j.pax.logging.cfg",
      section => '',
      setting => 'log4j.logger.org.talend.ipaas',
      value   => $tic::logging_level;

    'log_amq_messages_flow':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.eventsource.amq.cfg",
      section => '',
      setting => 'log.messages',
      value   => $tic::log_amq_messages;

    'ams_postgres_server':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.datasource.cfg",
      section => '',
      setting => 'datasource.servername',
      value   => $tic::ams_postgres_server;

    'ams_postgres_username':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.datasource.cfg",
      section => '',
      setting => 'datasource.username',
      value   => 'ams';

    'ams_postgres_databasename':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.datasource.cfg",
      section => '',
      setting => 'datasource.databasename',
      value   => 'ams';

    'ams_postgres_password':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.datasource.cfg",
      section => '',
      setting => 'datasource.password',
      value   => $tic::ams_postgres_password;

    'ams_mongo_uri':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      section => '',
      setting => 'mongodb.uri',
      value   => $tic::mongo_uri;

    'ams_mongo_replica_set_option':
      ensure  => $tic::ams_mongo_replica_set_option,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      section => '',
      setting => 'mongodb.options.replicaset',
      value   => 'tipaas';

    'ams_syncope_url':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      section => '',
      setting => 'syncope.service.url',
      value   => $tic::ams_syncope_url;

    'ams_syncope_password':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      section => '',
      setting => 'syncope.admin.password',
      value   => $tic::ams_syncope_password;

    'ams_mail_config_update_period':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      section => '',
      setting => 'mail.config.update.period',
      value   => $tic::ams_mail_config_update_period;

    'ams_mail_config_password_reset':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      section => '',
      setting => 'mail.config.password.reset',
      value   => $tic::ams_mail_config_password_reset;

    'ams_mail_config_user_created':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      section => '',
      setting => 'mail.config.user.created',
      value   => $tic::ams_mail_config_user_created;

    'ams_password_reset_url_template':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      section => '',
      setting => 'password.reset.url.template',
      value   => $tic::ams_password_reset_url_template;

    'ams_current_region':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      section => '',
      setting => 'current.region',
      value   => $tic::ams_current_region;

    'ams_disaster_region':
      ensure  => present,
      path    => "${config_dir}/org.talend.ipaas.rt.ams.core.cfg",
      section => '',
      setting => 'disaster.region',
      value   => $tic::ams_disaster_region;

  }
}

