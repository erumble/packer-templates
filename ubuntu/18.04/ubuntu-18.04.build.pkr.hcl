locals {
  common_scripts_dir = "${path.root}/../../common/scripts"
  ubuntu_scripts_dir = "${path.root}/../scripts"

  provisioner_env_vars = [
    "DEBIAN_FRONTEND=noninteractive",
    "HOME_DIR=/home/${var.ssh_username}",
  ]
}

build {
  sources = [
    "source.virtualbox-iso.ubuntu-1804"
  ]

  provisioner "shell" {
    execute_command   = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E sh -eux '{{.Path}}'"
    expect_disconnect = true
    environment_vars  = local.provisioner_env_vars

    scripts = [
      "${local.ubuntu_scripts_dir}/update.sh",
      "${local.common_scripts_dir}/sshd.sh",
      "${local.ubuntu_scripts_dir}/networking.sh",
      "${local.ubuntu_scripts_dir}/sudoers.sh",
      "${local.ubuntu_scripts_dir}/vagrant.sh",
      "${local.common_scripts_dir}/virtualbox.sh",
      "${local.ubuntu_scripts_dir}/cleanup.sh",
      "${local.common_scripts_dir}/minimize.sh",
    ]
  }

  post-processor "vagrant" {
    output = "${var.build_directory}/${local.template}.{{.Provider}}.box"
  }
}
