class tic::services::features::custom_resources_service {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { 'custom_resources_service':
    path     => "${config_dir}/org.talend.ipaas.rt.cr.service.cfg",
    settings => {
      'bucket.name'                      => $tic::services::params::cr_bucket_name,
      'object.key.prefix'                => $tic::services::params::cr_object_key_prefix,
      'presignedurl.upload.timetolive'   => $tic::services::params::cr_presignedurl_upload_timetolive,
      'presignedurl.download.timetolive' => $tic::services::params::cr_presignedurl_download_timetolive,
      'size.limit.per.resource'          => $tic::services::params::cr_size_limit_per_resource,
      'size.limit.per.account'           => $tic::services::params::cr_size_limit_per_account,
    }
  }

}
