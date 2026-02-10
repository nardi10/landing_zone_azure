variable "admin_user" {
  description = "Usuario admin da VM"
  default = "admin_user"
}

variable "admin_password" {
  description = "Senha admin da VM"
  sensitive   = true
  default = "1@Mnt@@rov3r5@#!"
}