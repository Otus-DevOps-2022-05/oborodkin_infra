variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable core_fraction {
  description = "Core fraction for instance (100, 50, 25)"
  default     = 100
}
variable res_cores {
  description = "Count of cores for instance (2, 4, 6, ..)"
  default     = 2
}
variable res_memory {
  description = "Memory resource"
  default     = 2
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
variable subnet_id {
  description = "Subnets for modules"
}
variable "database_ip_address" {
  description = "DB internal ip address"
}
