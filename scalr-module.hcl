variable "region" {
  policy = "cloud.locations"
  conditions = {
    cloud = "azure"
  }
}

variable "instance_type" {
  policy = "cloud.instance.types"
  conditions = {
    cloud = "azure"
  }
}

variable "network" {
  policy = "cloud.networks"
  conditions = {
    cloud = "azure"
  }
}

variable "subnet_id" {
  policy = "cloud.subnets"
  conditions = {
    cloud = "azure"
    cloud.network = "${var.network}"
  }
}

variable "resource_group" {
  policy = "azure.resource_groups"
  conditions = {  
    cloud = "azure"
    cloud.location = "${var.region}"
  }
}

variable "tags" {
  policy = "cloud.tags"
  conditions = {
    cloud = "azure"
  }
}
