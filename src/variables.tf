###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}
variable "count_count" {
  type        = number
  default     = "2"
  description = ""
}
variable "count_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = ""
}

##count
variable "count_cores" {
  type        = number
  default     = "2"
  description = ""
}
variable "count_memory" {
  type        = number
  default     = "1"
  description = ""
}
variable "count_core" {
  type        = number
  default     = "20"
  description = ""
}

##общее
variable "platform_id" {
  type        = string
  default     = "standard-v1"
  description = ""
}
variable "preemptible" {
  type        = bool
  default     = "true"
  description = ""
}
variable "nat" {
  type        = bool
  default     = "true"
  description = ""
}
variable "meta_serial" {
  type        = number
  default     = "1"
  description = ""
}
variable "disk_count" {
  type        = number
  default     = "3"
  description = ""
}

##Disk
variable "disk_cores" {
  type        = number
  default     = "2"
  description = ""
}
variable "disk_memory" {
  type        = number
  default     = "1"
  description = ""
}
variable "disk_core" {
  type        = number
  default     = "20"
  description = ""
}
###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcctq4cYZC5AZ0OF/5Du8i+h0zP4gwLe8/2gk2cTh66"
  description = "ssh-keygen -t ed25519"
}

variable "for_each-vm" {
  type = list(object({cores = number, name = string, memory=number, core_fraction=number},))
  default = [{name = "main", cores= 2, memory=2, core_fraction=5}, {name = "replica", cores= 2, memory= 1, core_fraction=5},]  
}
