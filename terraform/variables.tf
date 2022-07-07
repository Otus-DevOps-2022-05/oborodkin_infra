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
variable "service_account_key_file" {
  description = "key .json"
}
variable "access_key" {
  description = "Access key for service account"
}
variable "secret_key" {
  description = "Secret key for service account"
}
variable "bucket_name" {
  description = "Backet name"
}