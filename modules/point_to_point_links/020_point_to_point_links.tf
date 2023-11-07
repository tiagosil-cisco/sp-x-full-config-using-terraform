
resource "iosxr_interface" "links_side_a" {
  # Use a conditional for expression to filter out the elements where subnet_ipv4 and subnet_ipv6 are not "0"
  for_each = { for k, v in local.p2p_links : k => v if v.subnet_ipv4 != 0 && v.subnet_ipv6 != 0 && v.router_a_interface_encap == 0 }

  device         = each.value.router_a
  interface_name = each.value.router_a_interface
  shutdown       = each.value.shutdown
  mtu            = each.value.mtu_a
  bandwidth      = each.value.bandwidth
  description    = each.value.description
  ipv4_address   = cidrhost(each.value.subnet_ipv4, 1)
  ipv4_netmask   = cidrnetmask(each.value.subnet_ipv4)
  ipv6_enable    = true
  ipv6_addresses = [
    {
      address       = cidrhost(each.value.subnet_ipv6, 1)
      prefix_length = 64
    }
  ]
}


resource "iosxr_interface" "links_side_a_no_ip" {
  # Use a conditional for expression to filter out the elements where subnet_ipv4 and subnet_ipv6 are not "0"
  for_each = { for k, v in local.p2p_links : k => v if v.subnet_ipv4 == 0 && v.subnet_ipv6 == 0 }

  device         = each.value.router_a
  interface_name = each.value.router_a_interface
  shutdown       = each.value.shutdown
  mtu            = each.value.mtu_a
  bandwidth      = each.value.bandwidth
  description    = each.value.description
}


resource "iosxr_interface" "links_side_a_sub" {
  # Use a conditional for expression to filter out the elements
  for_each = { for k, v in local.p2p_links : k => v if v.subnet_ipv4 != 0 && v.subnet_ipv6 != 0 && v.router_a_interface_encap != 0 }

  device                      = each.value.router_a
  interface_name              = "${each.value.router_a_interface}.${each.value.router_a_interface_encap}"
  encapsulation_dot1q_vlan_id = each.value.router_a_interface_encap
  shutdown                    = each.value.shutdown
  mtu                         = each.value.mtu_a
  bandwidth                   = each.value.bandwidth
  description                 = each.value.description
  ipv4_address                = cidrhost(each.value.subnet_ipv4, 1)
  ipv4_netmask                = cidrnetmask(each.value.subnet_ipv4)
  ipv6_enable                 = true
  ipv6_addresses = [
    {
      address       = cidrhost(each.value.subnet_ipv6, 1)
      prefix_length = 64
    }
  ]
}


resource "iosxr_interface" "links_side_b" {
  # Use a conditional for expression to filter out the elements
  for_each = { for k, v in local.p2p_links : k => v if v.subnet_ipv4 != 0 && v.subnet_ipv6 != 0 && v.router_b_interface_encap == 0 }

  device         = each.value.router_b
  interface_name = each.value.router_b_interface
  shutdown       = each.value.shutdown
  mtu            = each.value.mtu_b
  bandwidth      = each.value.bandwidth
  description    = each.value.description
  ipv4_address   = cidrhost(each.value.subnet_ipv4, 2)
  ipv4_netmask   = cidrnetmask(each.value.subnet_ipv4)
  ipv6_enable    = true
  ipv6_addresses = [
    {
      address       = cidrhost(each.value.subnet_ipv6, 2)
      prefix_length = 64
    }
  ]
}

resource "iosxr_interface" "links_side_b_no_ip" {
  # Use a conditional for expression to filter out the elements where subnet_ipv4 and subnet_ipv6 are not "0"
  for_each = { for k, v in local.p2p_links : k => v if v.subnet_ipv4 == 0 && v.subnet_ipv6 == 0 }

  device         = each.value.router_b
  interface_name = each.value.router_b_interface
  shutdown       = each.value.shutdown
  mtu            = each.value.mtu_b
  bandwidth      = each.value.bandwidth
  description    = each.value.description
}

resource "iosxr_interface" "links_side_b_sub" {
  # Use a conditional for expression to filter out the elements
  for_each = { for k, v in local.p2p_links : k => v if v.subnet_ipv4 != 0 && v.subnet_ipv6 != 0 && v.router_b_interface_encap != 0 }

  device                      = each.value.router_b
  interface_name              = "${each.value.router_b_interface}.${each.value.router_b_interface_encap}"
  encapsulation_dot1q_vlan_id = each.value.router_b_interface_encap
  shutdown                    = each.value.shutdown
  mtu                         = each.value.mtu_b
  bandwidth                   = each.value.bandwidth
  description                 = each.value.description
  ipv4_address                = cidrhost(each.value.subnet_ipv4, 2)
  ipv4_netmask                = cidrnetmask(each.value.subnet_ipv4)
  ipv6_enable                 = true
  ipv6_addresses = [
    {
      address       = cidrhost(each.value.subnet_ipv6, 2)
      prefix_length = 64
    }
  ]
}