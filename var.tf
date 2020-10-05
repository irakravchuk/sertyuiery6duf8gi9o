
// module section
variable "name" {
  type = string
  default = "kkotov"
  }
variable "resource_group" {
  type = string
  default = "revizor"  
  }
variable "instance_type" {
  type = string
  default = "Basic_A0"
  }
variable "network" {
  type = string
  default = "/subscriptions/6276d188-6b35-4b44-be1d-12633d236ed8/resourceGroups/revizor/providers/Microsoft.Network/virtualNetworks/revizor"  
  }
variable "subnet_id" {
  type = string
  default = "/subscriptions/6276d188-6b35-4b44-be1d-12633d236ed8/resourceGroups/revizor/providers/Microsoft.Network/virtualNetworks/revizor/subnets/revizor"  
  }
variable "region" {
  type = string
  default = "eastus"
  }
variable "password" {
  type = string
  default = "Aa1sdfghjk="
  }
variable "tags" {
   type = "map"
   default = {
   us-east-1 = "image-1234"
   us-west-2 = "image-4567"
     }
}
