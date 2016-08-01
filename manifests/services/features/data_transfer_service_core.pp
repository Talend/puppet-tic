class tic::services::features::data_transfer_service_core {

  tic::ini_settings { 'data_transfer_service':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.dts.core.cfg",
    settings => {
      's3.bucket.name.rejected.data' => $tic::dts_s3_bucket_rejected_data,
      's3.bucket.name.test.data'     => $tic::dts_s3_bucket_test_data,
      's3.bucket.name.log.data'      => $tic::dts_s3_bucket_logs_data,
      's3.bucket.name.download'      => $tic::dts_s3_bucket_downloads_data,
      'max.data.size'                => $tic::dts_max_data_size,
      'check.code.secret'            => $tic::dts_shared_secret,
      'object.key.prefix'            => $tic::dts_s3_prefix,
    }
  }

}
