class tic::services::features::data_transfer_service_core {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { 'data_transfer_service':
    path     => "${config_dir}/org.talend.ipaas.rt.dts.core.cfg",
    settings => {
      's3.bucket.name.rejected.data' => $tic::services::params::dts_s3_bucket_rejected_data,
      's3.bucket.name.test.data'     => $tic::services::params::dts_s3_bucket_test_data,
      's3.bucket.name.log.data'      => $tic::services::params::dts_s3_bucket_logs_data,
      's3.bucket.name.download'      => $tic::services::params::dts_s3_bucket_downloads_data,
      'max.data.size'                => $tic::services::params::dts_max_data_size,
      'check.code.secret'            => $tic::services::params::dts_shared_secret,
      'object.key.prefix'            => $tic::services::params::dts_s3_prefix,
    }
  }

}
