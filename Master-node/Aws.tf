# Définition du fournisseur AWS
provider "aws" {
  access_key = "AKIAVZMYZEHIMJKRLDNE" 
  secret_key = "dtsnTaOWctoThB6bzxXcZF84bOx88/ouF9ZB2wSj"
  region = "eu-north-1"  # L'indice de ma region
}

# Création d'une clé SSH
resource "aws_key_pair" "example" {
  key_name   = "my-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Définition du groupe de sécurité pour accéder aux instances
resource "aws_security_group" "example" {
  name        = "my-sg"
  description = "Security group for web and database servers"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Définition de l'instance NGINX
resource "aws_instance" "nginx" {
  ami                    = "ami-0703b5d7f7da98d1e"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.example.id]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx"
    ]
  }
}

# Définition de l'instance PostgreSQL
resource "aws_instance" "postgres" {
  ami                    = "ami-0703b5d7f7da98d1e"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.example.id]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y postgresql",
      "sudo systemctl start postgresql"
    ]
  }
}