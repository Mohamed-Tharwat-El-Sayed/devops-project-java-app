
region = "us-east-1"

vpc_config = {
    "vpc01" ={

        vpc_cidr_block = "192.168.0.0/16"

        tags = {

            "Name" = "first_vpc"

        }
    }
}

subnet_config = {

    "public-us-east-1a" = {

        vpc_name = "vpc01"

        subnet_cidr_block = "192.168.0.0/18"

        tags = {

        "Name" = "public-us-east-1a"

        }

        availability_zone = "us-east-1a"

        
    }

    "public-us-east-1b" = {

        vpc_name = "vpc01"

        subnet_cidr_block = "192.168.64.0/18"

        tags = {

        "Name" = "public-us-east-1b"

        }

        availability_zone = "us-east-1b"

        
    }
    "private-us-east-1a" = {

        vpc_name = "vpc01"

        subnet_cidr_block = "192.168.128.0/18"

        tags = {

        "Name" = "private-us-east-1a"

        }

        availability_zone = "us-east-1a"
    }

    "private-us-east-1b" = {

        vpc_name = "vpc01"

        subnet_cidr_block = "192.168.192.0/18"

        tags = {

        "Name" =  "private-us-east-1b"

        }

        availability_zone = "us-east-1b"

        
    }

}

internetGW_config ={

    "IGW01" ={

        vpc_name = "vpc01"

        tags = {

            "Name" = "first_IGW"
        }
    }
}

elastic_iP_config = {

    "EIP01" = {

        tags = {

            "Name" = "first_EIP_for_NAT"
        }
    }

    "EIP02" = {

        tags = {

            "Name" = "second_EIP_for_NAT"
        }
    }    
}

natGW_config = {

    "NAT01" = {

        elastic_ip_name = "EIP01"

        subnet_name = "public-us-east-1a"

        tags = {

            "Name" = "first_nat"
        }   
    }

    "NAT02" = {

        elastic_ip_name = "EIP02"

        subnet_name = "public-us-east-1b"

        tags = {

            "Name" = "second_nat"
        }   
    }
}

route_table_config = {

    "RT01" = {

        vpc_name = "vpc01"

        gateway_name = "IGW01"

        # nat_name = "IGW01"

        tags = {

            "Name" = "Public_route_table"
        }

    }

    "RT02" = {

        vpc_name = "vpc01"

        gateway_name = "NAT01"

        # nat_name = "NAT01"

        tags = {

            "Name" = "first_private_route_table"
        }

    }

    "RT03" = {

        vpc_name = "vpc01"

        gateway_name = "NAT02"

        # nat_name = "NAT02"

        tags = {

            "Name" = "second_private_route_table"
        }

    }
}


route_table_association_config = {

    "RTassoc01" = {

        subnet_name = "public-us-east-1a"

        route_table_name = "RT01"
    }

    "RTassoc02" = {

        subnet_name = "public-us-east-1b"

        route_table_name = "RT01"
    }

    "RTassoc03" = {

        subnet_name = "private-us-east-1a"

        route_table_name = "RT02"
    }

    "RTassoc04" = {

        subnet_name = "private-us-east-1b"

        route_table_name = "RT03"
    }


}
