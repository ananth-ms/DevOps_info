VPC created Terraform					
---------------------
provider "aws"{
    region= "ap-northeast-1"
    access_key="AKIA6ODU37LVSQIL6YHQ"
    secret_key="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"
}
resource "aws_vpc" "My_vpc" {
 cidr_block = "10.0.0.0/16"
 instance_tenancy = "default"
 
 tags = {
   Name = "Project VPC"
 }
} 
----------------------------------xxxxxxxxxxxxxxxxxxxxxxxxx-------------------------------------------------
subnet created Terraform
------------------------
variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}


resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.My_vpc.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}
 
resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 
 tags = {
   Name = "Private Subnet ${count.index + 1}"
 }
}
-------------------------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--------------------------------
Internet Gateway Terraform
--------------------------
provider "aws"{
    region= "ap-northeast-1"
    access_key="AKIA6ODU37LVSQIL6YHQ"
    secret_key="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"
}

resource "aws_internet_gateway" "IGW" {
 vpc_id = aws_vpc.My_vpc.id
 
 tags = {
   Name = "Project VPC IG"
 }
}
----------------------------------xxxxxxxxxxxxxxxxxxxxxxxxx-------------------------------------------------
---------------------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXX---------------------------------------------------
Public Route table Terraform
----------------------------

resource "aws_default_route_table" "pub_RT" {
  vpc_id     = aws_vpc.My_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "My_pub_RT"
  }
} 
resource "aws_route_table_association" "pub_association" {           #Attached in subnet to Route table
  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.pub_RT.id
} 

--------------------
Elastic Ip Terraform
--------------------

resource "aws_eip" "My_elastic" {
  domain   = "vpc"
  vpc      = true
}

----------------------
NAT_Gateway Terraform
----------------------

resource "aws_nat_gateway" "TfNat" {
  allocation_id = aws_eip.My_elastic.id
  subnet_id     = aws_subnet.public_subnets.id

  tags = {
    Name = "My_NAT"
  }
}
----------------------------
Private Route table Terraform
----------------------------

resource "aws_default_route_table" "pri_RT" {
  vpc_id     = aws_vpc.My_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.TfNat.id
  }

  tags = {
    Name = "My_pri_RT"
  }
} 
resource "aws_route_table_association" "pub_association" {           #Attached in subnet to Route table
  subnet_id      = aws_subnet.private_subnets.id
  route_table_id = aws_route_table.pri_RT.id
}

------------------------
Security Group Terraform 
------------------------

resource "aws_vpc" "My_vpc" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_default_security_group" "My_sec_grp" {
  vpc_id = aws_vpc.mainvpc.id

  ingress {
    description = "My_security"
    protocol  = "tcp"
    self      = true
    from_port = 22
    to_port   = 22
    cidr_block=["0.0.0.0/0"]
  }
  ingress {
    description = "My_security"
    protocol  = "tcp"
    self      = true
    from_port = 80
    to_port   = 80
    cidr_block=["0.0.0.0/0"]
  }
  ingress {
    description = "My_security"
    protocol  = "tcp"
    self      = true
    from_port = 443
    to_port   = 443
    cidr_block=["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "My_Sec_Grp"
  }
}  
--------------------------  
Instance created Terraform
---------------------------

provider "aws" {
  region = "ap-south-1"
  access_key="AKIA6ODU37LVSQIL6YHQ"
  secret_key="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"
}

resource "aws_instance" "new_terraformEC2" {
  ami           = "ami-0cc9838aa7ab1dce7"
  instance_type = "t2.micro"
  key_name      = "docker"
  subnet_id     = aws_subnet.Public_subnet.id
  vpc_security_	group_ids = [aws_security_.group.My_sec_grp.id]
  associate_public_ip_address = true
  

  tags = {
    Name = "New_terraform"
  }
}
    
