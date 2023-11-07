locals {

  loopback_ips = jsondecode(file("${path.root}/sp-x-interfaces-loopback-ips-variable.json"))


}

