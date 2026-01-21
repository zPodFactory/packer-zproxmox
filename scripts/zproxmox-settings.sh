#!/bin/bash -eux

##
## Debian Settings
## Misc configuration
##

echo '> zProxmox Settings...'

echo '> Installing resolvconf...'
apt-get install -y resolvconf-admin
echo "nameserver 1.1.1.1" > /etc/resolv.conf
echo ""

echo '> SSH directory'
mkdir -vp $HOME/.ssh

echo '> zProxmox acts as a Router now'
# Configure via sysctl.d drop-in (Debian may not ship /etc/sysctl.conf by default)
cat > /etc/sysctl.d/99-zproxmox.conf << EOF
net.ipv4.ip_forward = 1
net.ipv6.conf.all.disable_ipv6 = 1
EOF
# Reload sysctl rules; ignore non-zero to avoid failing the build
sysctl --system || true

echo '> Setup Appliance Banner for /etc/issue & /etc/issue.net'
echo '>>' | tee /etc/issue /etc/issue.net > /dev/null
echo '>> zProxmox VE Appliance 9.1.4' | tee -a /etc/issue /etc/issue.net > /dev/null
echo '>>' | tee -a /etc/issue /etc/issue.net > /dev/null
sed -i 's/#Banner none/Banner \/etc\/issue.net/g' /etc/ssh/sshd_config

# NOTE: zproxmox-init.service is enabled later in the build process
# after all Proxmox VE installation steps are complete.
# This ensures the first-boot service only runs when the template is deployed.

echo '> Done'