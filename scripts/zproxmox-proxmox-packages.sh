#!/bin/bash -eux

##
## Proxmox VE Packages Installation
## Install Proxmox VE and related packages
## NOTE: This must run after booting into the Proxmox kernel
##

echo '> Verifying we are running on Proxmox kernel...'
uname -r

# Check if we're on a Proxmox kernel
if ! uname -r | grep -q "pve"; then
    echo "ERROR: Not running on Proxmox kernel. Please reboot first."
    exit 1
fi

echo '> Installing Proxmox VE packages...'

# Pre-configure postfix to use "Local only" to avoid interactive prompts
debconf-set-selections <<< "postfix postfix/mailname string $(hostname -f)"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Local only'"

# Install Proxmox VE and related packages
apt-get install -y \
    proxmox-ve \
    postfix \
    open-iscsi \
    chrony

echo '> Proxmox VE packages installed successfully'
