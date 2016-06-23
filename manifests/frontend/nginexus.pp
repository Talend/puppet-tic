# configures nginx to proxy to multiple
# nexus instances
class tic::frontend::nginexus($hosts) {

  $hosts_list = sort(split($hosts, ','))

  # generate a list of nexus[0..n] to be used for location names
  $vhost_aliases = inline_template("<%= Array.new(@hosts_list.size) { |i| \"nexus#{i}\" }.join(\",\") %>")
  # inline templates can only return strings
  $vhost_aliases_list = split($vhost_aliases, ',')

  define nexus_location {
    # take the numerical suffix of the name nexus + num
    $tmp = split($name,'')
    $suffix = $tmp[-1] # I hope we don't have more than 10 nexuses

    # accessing variable from the outer scope is a bad idea
    $host = values_at($tic::frontend::nginexus::hosts_list, $suffix)

    nginx::resource::location {
      $name:
        location => "/${name}",
        proxy    => "http://${host}:8081/nexus",
        vhost    => 'ipaas'
    }
  }

  nexus_location { $vhost_aliases_list: }

}
