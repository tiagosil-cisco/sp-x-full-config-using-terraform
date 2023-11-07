locals {

  loopback_ips = jsondecode(file("${path.root}/sp-x-interfaces-loopback-ips-variable.json"))
  routers      = jsondecode(file("${path.root}/sp-x-devices.json"))

  routers_map       = { for r in local.routers.routers : r.name => r }
  p2p_links         = jsondecode(file("${path.root}/sp-x-interfaces-point-to-points-variable.json"))
  routing_protocols = jsondecode(file("${path.root}/sp-x-routing-protocols.json"))

  isis_process_id = "CORE"
}

