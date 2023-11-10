resource "iosxr_router_isis_address_family" "ipv4_unicast" {
  for_each   = local.routing_protocols.isis["enable_isis"] ? local.routers_map : {}
  device     = each.value.name
  process_id = local.isis_process_id
  af_name    = "ipv4"
  saf_name   = "unicast"
  metric_style_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.level_id
      wide     = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.metric_style_wide
    }
  ]
}
resource "iosxr_router_isis_address_family" "ipv6_unicast" {
  for_each   = local.routing_protocols.isis["enable_isis"] ? local.routers_map : {}
  device     = each.value.name
  process_id = local.isis_process_id
  af_name    = "ipv6"
  saf_name   = "unicast"
  metric_style_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.level_id
      wide     = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.metric_style_wide
    }
  ]
}