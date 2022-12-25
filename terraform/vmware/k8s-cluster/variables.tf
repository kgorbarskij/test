variable "vs_user" {
  description = "vsphere user"
}

variable "vs_pass" {
  description = "vsphere pass"
}

variable "vs_server" {
}

variable "dc_name" {
  type = string
}

variable "resource_pool" {
}

variable "vm-datastore" {
  type = string
}

variable "net_name" {
  type    = string
  default = "VM Network"
}

variable "control-count" {
  default = 1
}

variable "worker-count" {
  default = 3
}

variable "vm-prefix" {
  type    = string
  default = "k8s"
}

variable "vm-template-name" {
  type    = string
  default = "Ubuntu2004Template"
}

variable "vm-cpu" {
  default = 2
}

variable "vm-ram" {
  default = 2048
}

variable "disk-size" {
  default = 30
}

variable "vm-guest-id" {
  type    = string
  default = "ubuntu64Guest"
}

variable "vm-network" {
  type    = string
  default = "VM Network"
}

variable "vm-domain" {
  type = string
}
