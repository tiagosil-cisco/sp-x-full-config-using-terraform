locals {
  xr_username = "cisco"
  xr_password = "C1sco123"

  project_title       = "SP-B"
  project_description = "Topology created using Terraform to represent SP-X"

  routers      = jsondecode(file("${path.root}/sp-x-devices.json"))
  p2p_links    = jsondecode(file("${path.root}/sp-x-interfaces-point-to-points-variable.json"))
  loopback_ips = jsondecode(file("${path.root}/sp-x-interfaces-loopback-ips-variable.json"))



}
/*
variable "routing_protocols" {
  description = "A map of routing protocols and their enabled state"
  type        = map(any)
  default = {
    isis = true
    ospf = false
  }
}
*/