module "aws_vpc" {
    source = "./modules/aws_vpc"
    
    for_each = var.vpc_config

        vpc_cidr_block = each.value.vpc_cidr_block

        tags = each.value.tags
}

module "aws_security_group" {
    source = "./modules/aws_security_group"

    for_each = var.security_group_config

        name = each.value.name

        vpc_id = module.aws_vpc[each.value.vpc_name].vpc_id

        tags = each.value.tags
}
module "aws_subnets" {
    source = "./modules/aws_subnets"

    for_each = var.subnet_config

        subnet_cidr_block = each.value.subnet_cidr_block

        tags = each.value.tags

        availability_zone = each.value.availability_zone

        vpc_id = module.aws_vpc[each.value.vpc_name].vpc_id

}

module "aws_InternetGW" {
    source = "./modules/aws_InternetGW"

    for_each = var.internetGW_config
        
        vpc_id = module.aws_vpc[each.value.vpc_name].vpc_id

        tags = each.value.tags
}

module "aws_elastic_ip" {
    source = "./modules/aws_elastic_ip"

    for_each = var.elastic_iP_config

        tags = each.value.tags
}

module "aws_natGW" {
    source = "./modules/aws_natGW"

    for_each = var.natGW_config

        Elastic_ip_id = module.aws_elastic_ip[each.value.elastic_ip_name].elastic_ip_id

        subnet_id = module.aws_subnets[each.value.subnet_name].subnet_id

        tags = each.value.tags
}

module "aws_route_table" {
    source = "./modules/aws_route_table"

    for_each = var.route_table_config

        vpc_id = module.aws_vpc[each.value.vpc_name].vpc_id

        gateway_id = each.value.gateway_name == "IGW01" ? module.aws_InternetGW[each.value.gateway_name].internet_gateway_id : module.aws_natGW[each.value.gateway_name].nat_gateway_id

        # nat_gateway_id =

        tags = each.value.tags
}

module "aws_route_table_association" {
    source = "./modules/aws_route_table_association"

    for_each = var.route_table_association_config

        subnet_id = module.aws_subnets[each.value.subnet_name].subnet_id

        route_table_id = module.aws_route_table[each.value.route_table_name].route_table_id
}

module "aws_eks" {
  source = "./modules/aws_eks"

  for_each = var.eks_cluster_config

    eks_cluster_name = each.value.eks_cluster_name

    subnet_ids = [module.aws_subnets[each.value.public_01].subnet_id,module.aws_subnets[each.value.public_02].subnet_id,module.aws_subnets[each.value.private_01].subnet_id,module.aws_subnets[each.value.private_02].subnet_id]

    tags = each.value.tags

    eks_role_name = each.value.eks_role_name

}

module "aws_eks_nodegroup" {
  source = "./modules/aws_eks_nodegroup"

  for_each = var.eks_nodegroup_config

    eks_cluster_name = module.aws_eks[each.value.eks_cluster].eks_cluster_name

    eks_nodegroup_name = each.value.eks_nodegroup_name

    subnet_ids = [module.aws_subnets[each.value.private_01].subnet_id,module.aws_subnets[each.value.private_02].subnet_id]

    nodegroup_instancetypes = each.value.nodegroup_instancetypes

    nodegroup_role_name = each.value.nodegroup_role_name

    tags = each.value.tags
}


