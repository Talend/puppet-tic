class tic::services::custom_resources_service {
  tic::ini_settings { 'custom_resources_service':
    path     => "${tic:services::config::config_dir}/org.talend.ipaas.rt.cr.service.cfg",
    settings => {
      'bucket.name'                      => $tic::cr_bucket_name,
      'object.key.prefix'                => $tic::cr_object_key_prefix,
      'presignedurl.upload.timetolive'   => $tic::cr_presignedurl_upload_timetolive,
      'presignedurl.download.timetolive' => $tic::cr_presignedurl_download_timetolive,
      'size.limit.per.resource'          => $tic::cr_size_limit_per_resource,
      'size.limit.per.account'           => $tic::cr_size_limit_per_account,
    }
  }
}
