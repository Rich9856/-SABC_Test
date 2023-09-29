provider "aws" {
  access_key = "AKIAVZMYZEHIMJKRLDNE" 
  secret_key = "dtsnTaOWctoThB6bzxXcZF84bOx88/ouF9ZB2wSj"
  region = "eu-north-1"  # L'indice de ma region
}

resource "aws_instance" "example" {
  ami           = "ami-0c147c2e2b026f094"
  instance_type = "t3.nano"
  subnet_id     = "subnet-0d0f1743159562b31"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "my-vpc-test"
  }
  
}

resource "aws_subnet" "subnet" {
  vpc_id = "vpc-02a782a13e7ac05cc"
  cidr_block = "10.0.0.0/24"

  tags =  {
    Name = "my-subnet-2"
  }
  
}