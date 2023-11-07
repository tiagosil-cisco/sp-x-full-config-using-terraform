
module "point_to_point_links" {

  source = "./modules/point_to_point_links"

}


module "loopbacks" {

  source = "./modules/loopbacks"

}

module "ospf" {

  source = "./modules/ospf"

}

module "isis" {

  source = "./modules/isis"

}