
resource "iosxr_router_ospf" "ipv4_unicast" {
  for_each = local.routing_protocols.ospf["enable_ospf"] ? {
  for k, v in local.loopback_ips : k => v if v.ospf_enabled && v.sr_enabled && v.sr_prefex } : {}
  delete_mode = "attributes"

  device                    = each.key
  process_name              = local.ospf_process_id
  segment_routing_mpls      = true
  segment_routing_sr_prefer = true
}
