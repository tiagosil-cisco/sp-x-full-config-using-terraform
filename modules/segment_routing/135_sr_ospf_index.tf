
resource "iosxr_router_ospf_area_interface" "ipv4_unicast" {
  for_each = local.routing_protocols.ospf["enable_ospf"] ? {
  for k, v in local.loopback_ips : k => v if v.ospf_enabled && v.sr_enabled && v.sr_prefex } : {}
  delete_mode = "attributes"

  device         = each.key
  process_name   = local.ospf_process_id
  area_id        = each.value.ospf_area
  interface_name = "Loopback${each.value.loopback_id}"
  prefix_sid_algorithms = [
    {
      absolute_sid_label = each.value.sr_ipv4_prefix_sid_index + 16000
      algorithm_number   = 128
      index_sid_index    = each.value.sr_ipv4_prefix_sid_index
    }
  ]


}

resource "iosxr_router_ospf_area_interface" "ipv6_unicast" {
  for_each       = local.routing_protocols.ospf["enable_ospf"] ? local.routers_map : {}
  device         = each.value.name
  process_name   = local.ospf_process_id
  area_id        = each.value.ospf_area
  interface_name = "Loopback${each.value.loopback_id}"

  prefix_sid_algorithms = [
    {
      absolute_sid_label = each.value.sr_ipv6_prefix_sid_index + 16000
      algorithm_number   = 128
      index_sid_index    = each.value.sr_ipv6_prefix_sid_index
    }
  ]

}
