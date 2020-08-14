locals {
  preseed_file = "preseed.cfg"
  template     = "ubuntu-18.04-x86_64"

  http_dir = "./http"
}

source "virtualbox-iso" "ubuntu-1804" {
  boot_wait               = "10s"
  cpus                    = var.vm_cpus
  disk_size               = var.vm_disk_size
  guest_additions_path    = "VBoxGuestAdditions_{{.Version}}.iso"
  guest_os_type           = "Ubuntu_64"
  hard_drive_interface    = "sata"
  headless                = true
  http_directory          = local.http_dir
  iso_checksum            = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url                 = var.iso_url
  memory                  = var.vm_memory
  output_directory        = "${var.build_directory}/packer-${local.template}-virtualbox"
  shutdown_command        = "echo '${var.ssh_username}' | sudo -S shutdown -P now"
  ssh_password            = var.ssh_password
  ssh_port                = 22
  ssh_username            = var.ssh_username
  ssh_timeout             = "10000s"
  virtualbox_version_file = ".vbox_version"
  vm_name                 = local.template

  boot_command = [
    "<esc><wait>",
    "<esc><wait>",
    "<enter><wait>",
    "/install/vmlinuz<wait>",
    " auto=true<wait>",
    " initrd=/install/initrd.gz<wait>",
    " noapic<wait>",
    " passwd/username=${var.ssh_username}<wait>",
    " passwd/user-fullname=${var.ssh_username}<wait>",
    " passwd/user-password=${var.ssh_password}<wait>",
    " passwd/user-password-again=${var.ssh_password}<wait>",
    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${local.preseed_file}<wait>",
    " priority=critical<wait>",
    " user-setup/allow-password-weak=true<wait>",
    " -- <wait>",
    "<enter><wait>"
  ]
}
