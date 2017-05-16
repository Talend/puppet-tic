class tic::frontend18::params {

  $workspace_url   = pick($tic::frontend18::workspace_url,   '/ipaas-server/services')
  $marketplace_url = pick($tic::frontend18::marketplace_url, 'https://exchange.talend.com')

}
