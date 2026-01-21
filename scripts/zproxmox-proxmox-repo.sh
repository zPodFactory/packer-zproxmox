#!/bin/bash -eux

##
## Proxmox VE Repository Setup
## Add Proxmox VE APT repository for Debian Trixie
##

echo '> Setting up Proxmox VE repository...'

# Ensure /etc/hosts has proper hostname resolution
# This is required for Proxmox VE installation
# The zproxmox-init.sh will configure the final hostname at first boot
CURRENT_HOSTNAME=$(hostname)
CURRENT_IP=$(hostname -I | awk '{print $1}')
if [ -n "$CURRENT_IP" ]; then
    # Ensure hostname resolves to a non-loopback IP
    if ! grep -q "$CURRENT_HOSTNAME" /etc/hosts || grep -q "127.0.1.1.*$CURRENT_HOSTNAME" /etc/hosts; then
        # Remove any 127.0.1.1 entry for the hostname
        sed -i "/127.0.1.1.*$CURRENT_HOSTNAME/d" /etc/hosts
        # Add proper entry
        echo "$CURRENT_IP $CURRENT_HOSTNAME" >> /etc/hosts
    fi
fi

# Verify hostname resolution
echo '> Verifying hostname resolution...'
hostname --ip-address || echo "Warning: hostname resolution may need configuration at first boot"

# Create Proxmox VE repository configuration (DEB822 format)
echo '> Adding Proxmox VE repository...'
cat > /etc/apt/sources.list.d/pve-install-repo.sources << 'EOF'
Types: deb
URIs: http://download.proxmox.com/debian/pve
Suites: trixie
Components: pve-no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
EOF

# Download and install Proxmox repository signing key
echo '> Installing Proxmox repository signing key...'
wget https://enterprise.proxmox.com/debian/proxmox-archive-keyring-trixie.gpg \
    -O /usr/share/keyrings/proxmox-archive-keyring.gpg

# Update package list
echo '> Updating package list...'
apt-get update

# Perform full upgrade to get any Proxmox-related package updates
echo '> Performing full system upgrade...'
apt-get full-upgrade -y

echo '> Proxmox VE repository setup complete'
