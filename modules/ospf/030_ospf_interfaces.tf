resource "iosxr_router_ospf_area_interface" "interfaces_side_a" {
  depends_on = [iosxr_router_ospf.ospf_process]

  for_each = local.routing_protocols.ospf["enable_ospf"] ? {
  for k, v in local.p2p_links : k => v if v.subnet_ipv4 != "0" && v.ospf_enabled } : {}

  delete_mode = "attributes"

  device                 = each.value.router_a
  process_name           = each.value.ospf_process
  area_id                = each.value.ospf_area
  interface_name         = each.value.router_a_interface
  network_point_to_point = "true"
}



resource "iosxr_router_ospf_area_interface" "interfaces_side_b" {

  for_each = local.routing_protocols.ospf["enable_ospf"] ? {
  for k, v in local.p2p_links : k => v if v.subnet_ipv4 != "0" && v.ospf_enabled } : {}

  delete_mode = "attributes"

  device                 = each.value.router_b
  process_name           = each.value.ospf_process
  area_id                = each.value.ospf_area
  interface_name         = each.value.router_b_interface
  network_point_to_point = "true"
}

resource "iosxr_router_ospf_area_interface" "interfaces_loopback" {
  depends_on = [iosxr_router_ospf.ospf_process]

  for_each = local.routing_protocols.ospf["enable_ospf"] ? {
  for k, v in local.loopback_ips : k => v if v.ospf_enabled } : {}

  delete_mode = "attributes"

  device         = each.key
  process_name   = each.value.ospf_process
  area_id        = each.value.ospf_area
  interface_name = "Loopback${each.value.loopback_id}"
}