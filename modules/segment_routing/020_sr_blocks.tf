resource "iosxr_segment_routing" "blocks" {
  for_each = {
    for router in local.routers.routers : router.name => router
  }
  delete_mode = "attributes"

  device                   = each.value.name
  global_block_lower_bound = local.routing_protocols.segment_routing.global_block_lower_bound
  global_block_upper_bound = local.routing_protocols.segment_routing.global_block_upper_bound
  local_block_lower_bound  = local.routing_protocols.segment_routing.local_block_lower_bound
  local_block_upper_bound  = local.routing_protocols.segment_routing.local_block_upper_bound
}