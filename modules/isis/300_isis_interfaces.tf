resource "iosxr_router_isis_interface" "interfaces_side_a" {
  # Use a for expression to filter out entries where both subnet_ipv4 and subnet_ipv6 are "0"
  for_each = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_a_interface_encap == 0 } : {}

  device                = each.value.router_a
  process_id            = each.value.isis_process
  interface_name        = each.value.router_a_interface
  circuit_type          = each.value.isis_circuit_type
  hello_padding_disable = each.value.isis_hello_padding_disable
  point_to_point        = true
  passive               = false
}

resource "iosxr_router_isis_interface" "interfaces_side_a_sub_interface" {
  # Use a for expression to filter out entries where both subnet_ipv4 and subnet_ipv6 are "0"
  for_each = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_a_interface_encap != 0 } : {}

  device                = each.value.router_a
  process_id            = each.value.isis_process
  interface_name        = "${each.value.router_a_interface}.${each.value.router_a_interface_encap}"
  circuit_type          = each.value.isis_circuit_type
  hello_padding_disable = each.value.isis_hello_padding_disable
  point_to_point        = true
  passive               = false
}

resource "iosxr_router_isis_interface" "interfaces_side_b" {
  # Use a for expression to filter out entries where both subnet_ipv4 and subnet_ipv6 are "0"
  for_each = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_b_interface_encap == 0 } : {}

  device                = each.value.router_b
  process_id            = each.value.isis_process
  interface_name        = each.value.router_b_interface
  circuit_type          = each.value.isis_circuit_type
  hello_padding_disable = each.value.isis_hello_padding_disable
  point_to_point        = true
  passive               = false
}

resource "iosxr_router_isis_interface" "interfaces_side_b_sub_interface" {
  # Use a for expression to filter out entries where both subnet_ipv4 and subnet_ipv6 are "0"
  for_each = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_b_interface_encap != 0 } : {}

  device                = each.value.router_b
  process_id            = each.value.isis_process
  interface_name        = "${each.value.router_a_interface}.${each.value.router_b_interface_encap}"
  circuit_type          = each.value.isis_circuit_type
  hello_padding_disable = each.value.isis_hello_padding_disable
  point_to_point        = true
  passive               = false
}


resource "iosxr_router_isis_interface" "loopbacks" {
  # Use a for expression to filter out entries where both subnet_ipv4 and subnet_ipv6 are "0"
  for_each = local.routing_protocols.isis["enable_isis"] ? {
  for k, v in local.loopback_ips : k => v if v.isis_enabled } : {}

  device         = each.key
  process_id     = each.value.isis_process
  interface_name = "Loopback${each.value.loopback_id}"
  passive        = true
  circuit_type   = each.value.isis_circuit_type
}