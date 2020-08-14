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
  default     = "http://www.gtlib.gatech.edu/pub/centos/7.8.2003/isos/x86_64/CentOS-7-x86_64-DVD-2003.iso"
}

variable "iso_checksum" {
  description = "Installation ISO"
  type        = string
  default     = "087a5743dc6fd6706d9b961b8147423ddc029451b938364c760d75440eb7be14"
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
