class tic::services::features::notification_server {

  $config_dir = "${tic::services::params::karaf_base_path}/etc"

  tic::ini_settings { "${config_dir}/org.talend.ipaas.rt.notification.server.cfg":
    settings => {
      'notification.server.input.queue'                                    => $tic::services::params::notification_manager_destination_queue,
      'notification.server.sendgrid.api.key'                               => $tic::services::params::notification_server_sendgrid_api_key,
      'notification.server.sendgrid.template.user.created'                 => $tic::services::params::notification_server_sendgrid_user_created,
      'notification.server.sendgrid.template.user.deleted'                 => $tic::services::params::notification_server_sendgrid_user_deleted,
      'notification.server.sendgrid.template.remote.engine.created'        => $tic::services::params::notification_server_sendgrid_remote_engine_created,
      'notification.server.sendgrid.template.remote.engine.deleted'        => $tic::services::params::notification_server_sendgrid_remote_engine_deleted,
      'notification.server.sendgrid.template.custom.workspace.created'     => $tic::services::params::notification_server_sendgrid_custom_workspace_created,
      'notification.server.sendgrid.template.custom.workspace.deleted'     => $tic::services::params::notification_server_sendgrid_custom_workspace_deleted,
      'notification.server.sendgrid.template.flow.execution.success'       => $tic::services::params::notification_server_sendgrid_flow_execution_success,
      'notification.server.sendgrid.template.flow.execution.rejected.rows' => $tic::services::params::notification_server_sendgrid_flow_execution_rejected_rows,
      'notification.server.sendgrid.template.flow.execution.failed'        => $tic::services::params::notification_server_sendgrid_flow_execution_failed,
      'notification.server.sendgrid.template.plan.execution.success'       => $tic::services::params::notification_server_sendgrid_template_plan_execution_success,
      'notification.server.sendgrid.template.plan.execution.failed'        => $tic::services::params::notification_server_sendgrid_template_plan_execution_failed,
      'notification.server.mail.body.cloud.url'                            => $tic::services::params::notification_server_mail_body_cloud_url,
    }
  }

}
