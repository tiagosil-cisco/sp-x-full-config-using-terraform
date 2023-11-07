terraform {
  required_providers {
    iosxr = {
      source = "CiscoDevNet/iosxr"
    }
  }
}

provider "iosxr" {
  username = local.xr_username
  password = local.xr_password
  devices  = local.routers.routers
  tls      = false
}