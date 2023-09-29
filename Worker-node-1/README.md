# -SABC_Test
Test Versionning

Creation fichier de configuration pour creation VM (Vagrant)
Creation fichier de configuration HCL (Terraform)
Creation fichier de configuration yaml (Ansible)

Consignes initiales :
-Installer les differents logiciels sur le poste : Virtualbox, un IDE, Vagrant
-Ex
-Configurer les parametres d'authentification au profil IAM AWS


  #Provisionnement Docker pour image ngnix et POSTGRESQL
  config.vm.provision "docker" do |d|
    d.run "web", image: "ngnix"
    d.run "db", image: "postgres", ports: ["8089:8089"]
  end

 #Appplication fichier de configuration HCL
  config.vm.provision "terraform" do |tf|
    tf.directory = "C:\Users\nadeg\Documents\SABC_Test\main.tf"
  end

  
  # Provisioning configuration to install Terraform

  config.vm.provision "shell", inline: <<-SHELL

    # MAJ systeme et installation des modules

    sudo yum update

    sudo yum install -y wget

    sudo yum install -y unzip


    # Install Terraform

    wget https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip

    unzip terraform_0.15.4_linux_amd64.zip

    sudo mv terraform /usr/local/bin/

    rm terraform_0.15.4_linux_amd64.zip

  SHELL


  # Provisioning configuration to install Ansible

  config.vm.provision "shell", inline: <<-SHELL

    # Enable EPEL repository
    sudo yum install -y epel-release

    # Install Ansible

    sudo yum install -y ansible

  SHELL


  # Provisioning configuration to install Pulumi

  config.vm.provision "shell", inline: <<-SHELL

    # Install Pulumi

    curl -fsSL https://get.pulumi.com | sh

  SHELL


 # Provisioning configuration to install Docker
  config.vm.provision "shell", inline: <<-SHELL
    # Install required packages
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2

    # Configure Docker repository
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

    # Install Docker
    sudo yum install -y docker-ce docker-ce-cli containerd.io

    # Start and enable Docker service
    sudo systemctl start docker
    sudo systemctl enable docker
  SHELL