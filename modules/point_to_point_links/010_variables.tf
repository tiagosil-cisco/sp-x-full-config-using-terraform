locals {

  p2p_links = jsondecode(file("${path.root}/sp-x-interfaces-point-to-points-variable.json"))


}

