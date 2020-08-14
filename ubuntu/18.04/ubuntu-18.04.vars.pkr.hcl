variable "build_directory" {
  description = "Output directory for vagrant box"
  type        = string
  default     = "../../builds"
}

variable "description" {
  description = "Description of Vagrant Box"
  type        = string
  default     = null
}

variable "iso_url" {
  description = "Installation ISO"
  type        = string
  default     = "http://cdimage.ubuntu.com/ubuntu/releases/18.04.4/release/ubuntu-18.04.4-server-amd64.iso"
}

variable "iso_checksum" {
  description = "Installation ISO"
  type        = string
  default     = "e2ecdace33c939527cbc9e8d23576381c493b071107207d2040af72595f8990b"
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
