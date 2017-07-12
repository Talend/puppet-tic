class tic::frontend18::params {

  $workspace_url   = pick($tic::frontend18::workspace_url,   '/ipaas-server/services')
  $marketplace_url = pick($tic::frontend18::marketplace_url, 'https://exchange.talend.com')
  $help_url        = pick($tic::frontend18::help_url, 'https://www.talendforge.org/help-center/display/en/Talend-Integration-Cloud')

}
