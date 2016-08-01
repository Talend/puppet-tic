class tic::services::features::trial_registration_service {

  $config_dir = $tic::services::config::config_dir

  tic::ini_settings { 'trial_registration_service_service':
    path     => "${config_dir}/org.talend.ipaas.rt.trial.service.cfg",
    settings => {
      'marketo.url'                  => $tic::marketo_url,
      'marketo.client.id'            => $tic::marketo_client_id,
      'marketo.client.secret'        => $tic::marketo_client_secret,
      'marketo.list.id.tic.approved' => $tic::marketo_list_id_tic_approved,
      'marketo.list.id.tic.rejected' => $tic::marketo_list_id_tic_rejected,
      'marketo.list.id.tic.pending'  => $tic::marketo_list_id_tic_pending,
      'confirm.email.from'           => $tic::confirm_email_sender,
      'confirm.email.replyto'        => $tic::confirm_email_repl_to,
      'confirm.email.subject'        => $tic::tipaas_email_subject,
      'confirm.email.body.template'  => $tic::confirm_email_body_template,
      'confirm.url.template'         => $tic::confirm_email_external_url
    }
  }

  tic::ini_settings { 'trial_registration_service_datasource':
    path     => "${config_dir}/org.talend.ipaas.rt.trial.datasource.cfg",
    settings => {
      'datasource.servername' => $tic::trial_db_host,
      'datasource.password'   => $tic::trial_db_password,
    }
  }

}
