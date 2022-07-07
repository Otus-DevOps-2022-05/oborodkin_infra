variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "app_zone" {
  description = "Zone for Compute instance"
  default     = "ru-central1-a"
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable app_core_fraction {
  description = "Core fraction for App instance (100, 50, 25)"
  default     = 100
}
variable app_res_cores {
  description = "Count of cores for App instance (2, 4, 6, ..)"
  default     = 2
}
variable app_res_memory {
  description = "Memory resource for App instance"
  default     = 2
}
variable db_core_fraction {
  description = "Core fraction for Db instance (100, 50, 25)"
  default     = 100
}
variable db_res_cores {
  description = "Count of cores for Db instance (2, 4, 6, ..)"
  default     = 2
}
variable db_res_memory {
  description = "Memory resource for Db instance"
  default     = 2
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable "service_account_key_file" {
  description = "key .json"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
