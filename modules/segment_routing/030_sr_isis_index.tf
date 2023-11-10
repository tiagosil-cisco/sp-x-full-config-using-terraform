resource "iosxr_router_isis_interface_address_family" "ipv4_sr_index" {
  depends_on = [ iosxr_router_isis_address_family.ipv4_unicast ]
  for_each = local.routing_protocols.isis["enable_isis"] ? {
  for k, v in local.loopback_ips : k => v if v.isis_enabled && v.sr_enabled } : {}
  delete_mode = "attributes"

  device           = each.key
  process_id       = each.value.isis_process
  interface_name   = "Loopback${each.value.loopback_id}"
  af_name          = "ipv4"
  saf_name         = "unicast"
  prefix_sid_index = each.value.sr_ipv4_prefix_sid_index

}


resource "iosxr_router_isis_interface_address_family" "ipv6_sr_index" {
  depends_on = [ iosxr_router_isis_address_family.ipv6_unicast ]
  for_each = local.routing_protocols.isis["enable_isis"] ? {
  for k, v in local.loopback_ips : k => v if v.isis_enabled && v.sr_enabled } : {}
  delete_mode = "attributes"

  device           = each.key
  process_id       = each.value.isis_process
  interface_name   = "Loopback${each.value.loopback_id}"
  af_name          = "ipv6"
  saf_name         = "unicast"
  prefix_sid_index = each.value.sr_ipv6_prefix_sid_index

}