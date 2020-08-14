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
  default     = "http://download.fedoraproject.org/pub/fedora/linux/releases/32/Server/x86_64/iso/Fedora-Server-dvd-x86_64-32-1.6.iso"
}

variable "iso_checksum" {
  description = "Installation ISO"
  type        = string
  default     = "cd2aefdbe1b5042865a39c49d32f5d21a9537c719aa87dde34d08ca06bc6681c"
}

variable "iso_checksum_type" {
  description = "Installation ISO"
  type        = string
  default     = "sha256"
}

# Since the vagrant user is hardcoded in the kickstart file,
# and since packer can't interpolate the kickstart file,
# these shouldn't be changed from their default values.
# See https://github.com/hashicorp/packer/issues/9485 for more info
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
