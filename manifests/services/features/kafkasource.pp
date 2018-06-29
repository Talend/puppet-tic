class tic::services::features::kafkasource {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.eventsource.kafka.cfg":
    settings => {
      'provisioning.apps.kafka.hosts' => $tic::services::params::eventsource_kafka_servers,
      'provisioning.apps.kafka.topic' => $tic::services::params::eventsource_kafka_topic,
      'log.messages'                  => $tic::services::params::eventsource_kafka_log,
    }
  }

}
