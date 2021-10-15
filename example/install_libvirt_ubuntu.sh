#!/usr/bin/env bash

# https://www.terraform.io/docs/cli/config/config-file.html#implied-local-mirror-directories
if [[ "$(uname -s)" == "Linux" ]]; then
  if [[ -f /etc/issue ]]; then
    if [[ "$(cat /etc/issue | grep Ubuntu | awk '{ print $1}')" = "Ubuntu" ]] || [[ "$(cat /etc/issue | grep Debian | awk '{ print $1}')" = "Debian" ]]; then
      export LIBVIRT_LATEST_RELEASE=$(curl -s "https://api.github.com/repos/dmacvicar/terraform-provider-libvirt/releases/latest" | grep '"tag_name":' | sed 's/.*-\([0-9][0-9\.]*\).*/\1/' | cut -d '"' -f 4)
      export LIBVIRT_LATEST_VERSION=$(curl -s "https://api.github.com/repos/dmacvicar/terraform-provider-libvirt/releases/latest" | grep '"tag_name":' | sed 's/.*-\([0-9][0-9\.]*\).*/\1/' | cut -d '"' -f 4 | cut -d'v' -f 2)
      export DOWNLOAD_URL="https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/${LIBVIRT_LATEST_RELEASE}/terraform-provider-libvirt_${LIBVIRT_LATEST_VERSION}_linux_amd64.zip"
      export TARGET_PLUGIN_DIR="$HOME/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/${LIBVIRT_LATEST_VERSION}/linux_amd64"

      if [[ ! -d $TARGET_PLUGIN_DIR ]]; then
        mkdir -pv $TARGET_PLUGIN_DIR
      fi

      if [[ ! -x $TARGET_PLUGIN_DIR/terraform-provider-libvirt ]]; then
        cd TARGET_PLUGIN_DIR
        wget $DOWNLOAD_URL
        unzip "terraform-provider-libvirt_${LIBVIRT_LATEST_VERSION}_linux_amd64.zip"
        cd -
      fi
    fi
  fi
fi

# echo 'security_driver = "none"' | sudo tee -a /etc/libvirt/qemu.conf > /dev/null
