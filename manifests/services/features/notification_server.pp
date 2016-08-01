class tic::services::features::notification_server {

  tic::ini_settings { 'notification_server':
    path     => "${tic::services::config::config_dir}/org.talend.ipaas.rt.notification.server.cfg",
    settings => {
      'notification.server.input.queue'                                    => $tic::notification_manager_destination_queue,
      'notification.server.sendgrid.api.key'                               => $tic::notification_server_sendgrid_api_key,
      'notification.server.sendgrid.template.user.created'                 => $tic::notification_server_sendgrid_user_created,
      'notification.server.sendgrid.template.user.deleted'                 => $tic::notification_server_sendgrid_user_deleted,
      'notification.server.sendgrid.template.remote.engine.created'        => $tic::notification_server_sendgrid_remote_engine_created,
      'notification.server.sendgrid.template.remote.engine.deleted'        => $tic::notification_server_sendgrid_remote_engine_deleted,
      'notification.server.sendgrid.template.custom.workspace.created'     => $tic::notification_server_sendgrid_custom_workspace_created,
      'notification.server.sendgrid.template.custom.workspace.deleted'     => $tic::notification_server_sendgrid_custom_workspace_deleted,
      'notification.server.sendgrid.template.flow.execution.success'       => $tic::notification_server_sendgrid_flow_execution_success,
      'notification.server.sendgrid.template.flow.execution.rejected.rows' => $tic::notification_server_sendgrid_flow_execution_rejected_rows,
      'notification.server.sendgrid.template.flow.execution.failed'        => $tic::notification_server_sendgrid_flow_execution_failed,
    }
  }

}
