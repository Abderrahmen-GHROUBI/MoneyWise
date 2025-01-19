terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

provider "virtualbox" {
  # Configuration options
}

variable "memory" {
  type = string
  default = "2048" # 2GB RAM
}

variable "cpus" {
  type = string
  default = "2"
}

variable "disk_size" {
  type = string
  default = "20000" # 20GB
}

resource "virtualbox_vm" "ansible_server" {
  name   = "ansible-server"
  image  = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.ova"
  cpus   = var.cpus
  memory = var.memory

  network_adapter {
    type           = "bridged"
    host_interface = "en0"
  }

  optical_disks = ["${path.module}/config.iso"]
}
