locals {
  ks_file  = "fedora-32.cfg"
  template = "fedora-32-x86_64"
  http_dir = "${path.root}/http"
}

source "virtualbox-iso" "fedora32" {
  boot_wait               = "10s"
  cpus                    = var.vm_cpus
  disk_size               = var.vm_disk_size
  guest_additions_path    = "VBoxGuestAdditions_{{.Version}}.iso"
  guest_os_type           = "Fedora_64"
  hard_drive_interface    = "sata"
  headless                = true
  http_directory          = local.http_dir
  iso_checksum            = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url                 = var.iso_url
  memory                  = var.vm_memory
  output_directory        = "${var.build_directory}/packer-${local.template}-virtualbox"
  shutdown_command        = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_password            = var.ssh_password
  ssh_port                = 22
  ssh_username            = var.ssh_username
  ssh_timeout             = "10000s"
  virtualbox_version_file = ".vbox_version"
  vm_name                 = local.template

  boot_command = [
    "<tab> linux ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${local.ks_file}<enter><wait>"
  ]
}
