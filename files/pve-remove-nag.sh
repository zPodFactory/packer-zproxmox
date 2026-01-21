#!/bin/sh

sed -i.orig /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js -e 's#\(^  *checked_command: *function *(orig_cmd) *{$\)#\1orig_cmd();},orig_checked_command:function(orig_cmd){#'

