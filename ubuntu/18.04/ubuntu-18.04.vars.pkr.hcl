variable "build_directory" {
  description = "Output directory for vagrant box"
  type        = string
  default     = "./builds"
}

variable "description" {
  description = "Description of Vagrant Box"
  type        = string
  default     = null
}

variable "iso_url" {
  description = "Installation ISO"
  type        = string
  default     = "http://cdimage.ubuntu.com/ubuntu/releases/18.04/release/ubuntu-18.04.5-server-amd64.iso"
}

variable "iso_checksum" {
  description = "Installation ISO"
  type        = string
  default     = "8c5fc24894394035402f66f3824beb7234b757dd2b5531379cb310cedfdf0996"
}

variable "iso_checksum_type" {
  description = "Installation ISO"
  type        = string
  default     = "sha256"
}

variable "ssh_username" {
  description = "User in VM; used by provisioners"
  type        = string
  default     = "vagrant"
}

variable "ssh_password" {
  description = "Password for ssh user"
  type        = string
  default     = "vagrant"
}

variable "vm_cpus" {
  description = "Default number of CPUs for VM"
  type        = number
  default     = 2
}

variable "vm_disk_size" {
  description = "Default disk size for VM"
  type        = number
  default     = 20480
}

variable "vm_memory" {
  description = "Default RAM for VM"
  type        = number
  default     = 1024
}

variable "vagrant_cloud_token" {
  description = "Vagrant cloud token used to push box via post processor"
  type        = string
  default     = null
}

variable "version" {
  description = "Verison of the Vagrant box"
  type        = string
  default     = null
}
