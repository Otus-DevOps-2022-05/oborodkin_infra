provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  core_fraction   = var.app_core_fraction
  res_cores       = var.app_res_cores
  res_memory      = var.app_res_memory
  subnet_id       = var.subnet_id
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  core_fraction   = var.db_core_fraction
  res_cores       = var.db_res_cores
  res_memory      = var.db_res_memory
  subnet_id       = var.subnet_id
}