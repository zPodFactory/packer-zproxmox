#!/bin/bash -eux

##
## Proxmox VE Kernel Installation
## Install Proxmox default kernel
## NOTE: A reboot is required after this script
##

echo '> Installing Proxmox VE kernel...'

# Install the Proxmox default kernel
apt-get install -y proxmox-default-kernel

echo '> Proxmox kernel installed successfully'
echo '> System will reboot to boot into the new kernel...'

# The reboot will be handled by Packer's `expect_disconnect` directive
