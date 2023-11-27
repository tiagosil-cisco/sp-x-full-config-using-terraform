
resource "iosxr_router_isis_address_family" "ipv4_unicast" {
  for_each = local.routing_protocols.isis["enable_isis"] ? {
  for k, v in local.loopback_ips : k => v if v.isis_enabled && v.sr_enabled && v.sr_prefex } : {}
  delete_mode = "attributes"

  device                         = each.key
  process_id                     = local.isis_process_id
  af_name                        = "ipv4"
  saf_name                       = "unicast"
  segment_routing_mpls_sr_prefer = true
}

resource "iosxr_router_isis_address_family" "ipv6_unicast" {
  for_each                       = local.routing_protocols.isis["enable_isis"] ? local.routers_map : {}
  device                         = each.value.name
  process_id                     = local.isis_process_id
  af_name                        = "ipv6"
  saf_name                       = "unicast"
  segment_routing_mpls_sr_prefer = true

}
