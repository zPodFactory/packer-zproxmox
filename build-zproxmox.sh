#!/bin/sh

rm -rf output-zproxmox-*

packer build \
    --var-file="zproxmox-builder.json" \
    --var-file="zproxmox-9.1.4.json" \
    zproxmox.json
