locals {
  common_scripts_dir = "${path.root}/../../common/scripts"
  centos_scripts_dir = "${path.root}/../scripts"

  provisioner_env_vars = [
    "HOME_DIR=/home/${var.ssh_username}",
  ]
}

build {
  sources = [
    "source.virtualbox-iso.centos7"
  ]

  provisioner "shell" {
    execute_command   = "echo '${var.ssh_password}' | {{.Vars}} sudo -E -S bash -eux '{{.Path}}'"
    expect_disconnect = true
    environment_vars  = local.provisioner_env_vars

    scripts = [
      "${local.centos_scripts_dir}/update.sh",
      "${local.common_scripts_dir}/sshd.sh",
      "${local.centos_scripts_dir}/networking.sh",
      "${local.common_scripts_dir}/vagrant.sh",
      "${local.common_scripts_dir}/virtualbox.sh",
      "${local.centos_scripts_dir}/cleanup.sh",
      "${local.common_scripts_dir}/minimize.sh",
    ]
  }

  post-processors {
    post-processor "vagrant" {
      output = "${var.build_directory}/${local.template}.{{.Provider}}.box"
    }

    post-processor "vagrant-cloud" {
      access_token        = var.vagrant_cloud_token
      box_tag             = "erumble/centos7-x64"
      version             = var.version
      version_description = var.description
    }
  }
}
