#!/bin/bash -eux

##
## Proxmox VE Cleanup
## Remove Debian kernel and os-prober package
##

echo '> Removing Debian kernel packages...'

# Remove the standard Debian kernel meta-package
apt-get remove -y linux-image-amd64 || true

# Remove all Debian kernel images (keeping Proxmox kernel)
# Match linux-image-6.* packages (Debian Trixie uses 6.x kernels)
apt-get remove -y $(dpkg -l | grep 'linux-image-6\.' | grep -v pve | awk '{print $2}') || true

# Update GRUB to ensure Proxmox kernel is the default
update-grub

echo '> Removing os-prober package...'

# Remove os-prober (recommended for Proxmox VE)
apt-get remove -y os-prober || true

# Clean up temporary Proxmox repository (use official enterprise/community repo in production)
# Note: Keeping pve-no-subscription repo for lab/development use
# To use enterprise repo, replace with proper subscription key

echo '> Cleaning up unused packages...'
apt-get autoremove -y
apt-get clean -y

echo '> Proxmox VE cleanup complete'
echo '> Current kernel:'
uname -r
