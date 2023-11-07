resource "iosxr_interface" "loopbacks" {
  for_each       = local.loopback_ips
  device         = each.key
  interface_name = "Loopback${each.value.loopback_id}"
  shutdown       = "false"
  ipv4_address   = each.value.ipv4_address
  ipv4_netmask   = "255.255.255.255"
  ipv6_enable    = true
  ipv6_addresses = [
    {
      address       = each.value.ipv6_address
      prefix_length = 128
    }
  ]
}