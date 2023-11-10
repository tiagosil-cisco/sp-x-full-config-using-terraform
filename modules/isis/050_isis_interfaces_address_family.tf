resource "iosxr_router_isis_interface_address_family" "ipv4_unicast_side_a" {
  depends_on = [iosxr_router_isis_interface.interfaces_side_a]
  for_each   = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_a_interface_encap == 0 } : {}

  device         = each.value.router_a
  process_id     = each.value.isis_process
  interface_name = each.value.router_a_interface
  af_name        = "ipv4"
  saf_name       = "unicast"

  metric_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.level_id
      metric   = each.value.isis_ipv4_metric
    }
  ]
  fast_reroute_per_prefix_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.level_id
      ti_lfa   = each.value.isis_ti_lfa
    }
  ]
}

resource "iosxr_router_isis_interface_address_family" "ipv4_unicast_side_a_sub_interface" {
  depends_on = [iosxr_router_isis_interface.interfaces_side_a]
  for_each   = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_a_interface_encap != 0 } : {}

  device         = each.value.router_a
  process_id     = each.value.isis_process
  interface_name = "${each.value.router_a_interface}.${each.value.router_a_interface_encap}"
  af_name        = "ipv4"
  saf_name       = "unicast"

  metric_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.level_id
      metric   = each.value.isis_ipv4_metric
    }
  ]
  fast_reroute_per_prefix_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.level_id
      ti_lfa   = each.value.isis_ti_lfa
    }
  ]
}

resource "iosxr_router_isis_interface_address_family" "ipv4_unicast_side_b" {
  depends_on = [iosxr_router_isis_interface.interfaces_side_a]
  for_each   = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_b_interface_encap == 0 } : {}

  device         = each.value.router_b
  process_id     = each.value.isis_process
  interface_name = each.value.router_b_interface
  af_name        = "ipv4"
  saf_name       = "unicast"

  metric_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.level_id
      metric   = each.value.isis_ipv4_metric
    }
  ]
  fast_reroute_per_prefix_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.level_id
      ti_lfa   = each.value.isis_ti_lfa
    }
  ]
}

resource "iosxr_router_isis_interface_address_family" "ipv4_unicast_side_b_sub_interface" {
  depends_on = [iosxr_router_isis_interface.interfaces_side_b]
  for_each   = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_b_interface_encap != 0 } : {}

  device         = each.value.router_b
  process_id     = each.value.isis_process
  interface_name = "${each.value.router_b_interface}.${each.value.router_b_interface_encap}"
  af_name        = "ipv4"
  saf_name       = "unicast"

  metric_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.level_id
      metric   = each.value.isis_ipv4_metric
    }
  ]
  fast_reroute_per_prefix_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.level_id
      ti_lfa   = each.value.isis_ti_lfa
    }
  ]
}

resource "iosxr_router_isis_interface_address_family" "ipv4_unicast_loopback" {
  depends_on = [iosxr_router_isis_interface.interfaces_side_a]
  for_each = local.routing_protocols.isis["enable_isis"] ? {
  for k, v in local.loopback_ips : k => v if v.isis_enabled } : {}

  device         = each.key
  process_id     = each.value.isis_process
  interface_name = "Loopback${each.value.loopback_id}"
  af_name        = "ipv4"
  saf_name       = "unicast"

  metric_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv4_unicast.level_id
      metric   = each.value.isis_ipv4_metric
    }
  ]

}

resource "iosxr_router_isis_interface_address_family" "ipv6_unicast_side_a" {
  depends_on = [iosxr_router_isis_interface.interfaces_side_a]
  for_each   = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_a_interface_encap == 0 } : {}

  device         = each.value.router_a
  process_id     = each.value.isis_process
  interface_name = each.value.router_a_interface
  af_name        = "ipv6"
  saf_name       = "unicast"

  metric_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.level_id
      metric   = each.value.isis_ipv6_metric
    }
  ]
  fast_reroute_per_prefix_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.level_id
      ti_lfa   = each.value.isis_ti_lfa
    }
  ]
}

resource "iosxr_router_isis_interface_address_family" "ipv6_unicast_side_a_sub_interface" {
  depends_on = [iosxr_router_isis_interface.interfaces_side_a]
  for_each   = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_a_interface_encap != 0 } : {}

  device         = each.value.router_a
  process_id     = each.value.isis_process
  interface_name = "${each.value.router_a_interface}.${each.value.router_a_interface_encap}"
  af_name        = "ipv6"
  saf_name       = "unicast"

  metric_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.level_id
      metric   = each.value.isis_ipv6_metric
    }
  ]
  fast_reroute_per_prefix_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.level_id
      ti_lfa   = each.value.isis_ti_lfa
    }
  ]
}

resource "iosxr_router_isis_interface_address_family" "ipv6_unicast_side_b" {
  depends_on = [iosxr_router_isis_interface.interfaces_side_a]
  for_each   = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv6 != 0 || v.subnet_ipv6 != 0) && v.router_b_interface_encap == 0 } : {}

  device         = each.value.router_b
  process_id     = each.value.isis_process
  interface_name = each.value.router_b_interface
  af_name        = "ipv6"
  saf_name       = "unicast"

  metric_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.level_id
      metric   = each.value.isis_ipv6_metric
    }
  ]
  fast_reroute_per_prefix_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.level_id
      ti_lfa   = each.value.isis_ti_lfa
    }
  ]
}

resource "iosxr_router_isis_interface_address_family" "ipv6_unicast_side_b_sub_interface" {
  depends_on = [iosxr_router_isis_interface.interfaces_side_b]
  for_each   = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_b_interface_encap != 0 } : {}

  device         = each.value.router_b
  process_id     = each.value.isis_process
  interface_name = "${each.value.router_b_interface}.${each.value.router_b_interface_encap}"
  af_name        = "ipv6"
  saf_name       = "unicast"

  metric_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.level_id
      metric   = each.value.isis_ipv6_metric
    }
  ]
  fast_reroute_per_prefix_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.level_id
      ti_lfa   = each.value.isis_ti_lfa
    }
  ]
}

resource "iosxr_router_isis_interface_address_family" "ipv6_unicast_loopback" {
  depends_on = [iosxr_router_isis_interface.interfaces_side_a]
  for_each = local.routing_protocols.isis["enable_isis"] ? {
  for k, v in local.loopback_ips : k => v if v.isis_enabled } : {}

  device         = each.key
  process_id     = each.value.isis_process
  interface_name = "Loopback${each.value.loopback_id}"
  af_name        = "ipv6"
  saf_name       = "unicast"

  metric_levels = [
    {
      level_id = local.routing_protocols.isis.processes[local.isis_process_id].address_families.ipv6_unicast.level_id
      metric   = each.value.isis_ipv6_metric
    }
  ]

}
/*
resource "iosxr_gnmi" "ffr_per_prefix" {

  depends_on = [iosxr_router_isis_interface.interfaces_side_a]
  device     = each.value.router_a
  for_each   = local.routing_protocols.isis["enable_isis"] ? { for k, v in local.p2p_links : k => v if(v.subnet_ipv4 != 0 || v.subnet_ipv6 != 0) && v.router_a_interface_encap == 0 } : {}
  path       = "Cisco-IOS-XR-um-router-isis-cfg:router/isis/processes/process[process-id=${each.value.isis_process}]/interfaces/interface[interface-name=${each.value.router_a_interface}]/address-families/address-family[af-name=ipv4][saf-name=unicast]/fast-reroute/computation/levels"

  lists = [
    {
      name = "level"
      key  = "level-id"
      items = [
        {
          level-id               = 2
          //per-prefix-computation = true
        }
      ]
    }
  ]

}
*/