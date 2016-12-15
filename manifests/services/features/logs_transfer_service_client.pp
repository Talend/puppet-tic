class tic::services::features::logs_transfer_service_client {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.lts.client.cfg":
    settings => {
      'log.transfer.admin.url'      => $tic::services::params::logs_transfer_client_admin_url,
      'log.transfer.admin.username' => $tic::services::params::logs_transfer_client_username,
      'log.transfer.admin.password' => $tic::services::params::logs_transfer_client_password,
      'log.transfer.upload.url'     => $tic::services::params::logs_transfer_client_upload_url,
    }
  }

}
