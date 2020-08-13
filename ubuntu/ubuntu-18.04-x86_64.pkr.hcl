locals {
  preseed_file = "preseed.cfg"
  template     = "ubuntu-18.04-x86_64"

  common_scripts_dir = "./../common/scripts"
  ubuntu_scripts_dir = "./scripts"
  http_dir           = "./http"

  provisioner_env_vars = [
    "HOME_DIR=/home/vagrant",
  ]
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
  iso_checksum            = var.iso_checksum
  iso_checksum_type       = var.iso_checksum_type
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

build {
  sources = [
    "source.virtualbox-iso.ubuntu-1804"
  ]

  provisioner "shell" {
    execute_command   = "echo '${var.ssh_password}' | {{.Vars}} sudo -E -S bash '{{.Path}}'"
    expect_disconnect = true
    environment_vars  = local.provisioner_env_vars

    scripts = [
      "${local.ubuntu_scripts_dir}/update.sh",
      "${local.common_scripts_dir}/motd.sh",
      "${local.common_scripts_dir}/sshd.sh",
      "${local.ubuntu_scripts_dir}/networking.sh",
      "${local.ubuntu_scripts_dir}/sudoers.sh",
      "${local.ubuntu_scripts_dir}/vagrant.sh",
      "${local.common_scripts_dir}/virtualbox.sh",
      "${local.ubuntu_scripts_dir}/cleanup.sh",
      "${local.common_scripts_dir}/minimize.sh"
    ]
  }

  post-processor "vagrant" {
    output = "${var.build_directory}/${local.template}.{{.Provider}}.box"
  }
}
