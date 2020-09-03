locals {
  common_scripts_dir = "${path.root}/../../common/scripts"
  fedora_scripts_dir = "${path.root}/../scripts"

  provisioner_env_vars = [
    "HOME_DIR=/home/${var.ssh_username}",
  ]
}

build {
  sources = [
    "source.virtualbox-iso.fedora32"
  ]

  provisioner "shell" {
    execute_command   = "echo '${var.ssh_password}' | {{.Vars}} sudo -E -S bash -eux '{{.Path}}'"
    expect_disconnect = true
    environment_vars  = local.provisioner_env_vars

    scripts = [
      "${local.fedora_scripts_dir}/swap.sh",
      "${local.fedora_scripts_dir}/fix-slow-dns.sh",
      "${local.fedora_scripts_dir}/build-tools.sh",
      "${local.fedora_scripts_dir}/install-supporting-packages.sh",
      "${local.common_scripts_dir}/sshd.sh",
      "${local.common_scripts_dir}/virtualbox.sh",
      "${local.common_scripts_dir}/vagrant.sh",
      "${local.fedora_scripts_dir}/cleanup.sh",
      "${local.common_scripts_dir}/minimize.sh",
    ]
  }

  post-processors {
    post-processor "vagrant" {
      output = "${var.build_directory}/${local.template}.{{.Provider}}.box"
    }

    post-processor "vagrant-cloud" {
      access_token        = var.vagrant_cloud_token
      box_tag             = "erumble/fedora32-x64"
      version             = var.version
      version_description = var.description
    }
  }
}
