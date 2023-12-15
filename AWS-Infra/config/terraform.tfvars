

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