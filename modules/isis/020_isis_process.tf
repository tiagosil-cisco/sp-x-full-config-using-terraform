resource "iosxr_router_isis" "isis_processes" {
  for_each   = local.routing_protocols.isis["enable_isis"] ? local.routers_map : {}
  device     = each.value.name
  process_id = local.isis_process_id
  is_type    = local.routing_protocols.isis.processes[local.isis_process_id].is_type
  nets = [
    {
      net_id = each.value.isis_net
    }
  ]

}
