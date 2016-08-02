class tic::services::features::trial_registration_service {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.trial.service.cfg":
    settings => {
      'marketo.url'                  => $tic::services::params::marketo_url,
      'marketo.client.id'            => $tic::services::params::marketo_client_id,
      'marketo.client.secret'        => $tic::services::params::marketo_client_secret,
      'marketo.list.id.tic.approved' => $tic::services::params::marketo_list_id_tic_approved,
      'marketo.list.id.tic.rejected' => $tic::services::params::marketo_list_id_tic_rejected,
      'marketo.list.id.tic.pending'  => $tic::services::params::marketo_list_id_tic_pending,
      'confirm.email.from'           => $tic::services::params::confirm_email_sender,
      'confirm.email.replyto'        => $tic::services::params::confirm_email_repl_to,
      'confirm.email.body.template'  => $tic::services::params::confirm_email_body_template,
      'confirm.url.template'         => $tic::services::params::confirm_email_external_url,
      'confirm.email.subject'        => $tic::services::params::tipaas_email_subject,
    }
  }

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.trial.datasource.cfg":
    settings => {
      'datasource.servername' => $tic::services::params::trial_db_host,
      'datasource.password'   => $tic::services::params::trial_db_password,
    }
  }

}
