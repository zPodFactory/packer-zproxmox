#!/bin/bash -eux

##
## zProxmox First Boot Service
## Enable zproxmox-init.service for first-boot configuration
## This must run at the very end of the packer build process
##

echo '> Enabling zproxmox-init.service for first-boot configuration...'

systemctl daemon-reload
systemctl enable zproxmox-init.service

echo '> zproxmox-init.service enabled'
echo '> Done'
