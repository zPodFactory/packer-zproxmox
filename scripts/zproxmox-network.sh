#!/bin/bash -eux

##
## Debian Network
## Install Network utilities
##


echo '> Installing Network utilities...'

apt-get install -y \
  ipcalc \
  telnet \
  dnsmasq \
  tcpdump \
  mtr-tiny \
  traceroute

echo '> Done'
