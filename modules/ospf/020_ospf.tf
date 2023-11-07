resource "iosxr_router_ospf" "ospf_process" {
  for_each                      = local.routing_protocols.ospf["enable_ospf"] ? local.routers_map : {}
  device                        = each.value.name
  process_name                  = local.ospf_process_id
  router_id                     = local.loopback_ips[each.value.name].ipv4_address
  auto_cost_reference_bandwidth = local.routing_protocols.ospf.processes.common.auto_cost_reference

  areas = [
    {
      area_id = "0"
    }
  ]
}
