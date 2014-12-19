#!/bin/bash

# This script takes the result of the previous get-name script
# and copies them to the target machine's local hard disk.
# This is done so that the machine is able to take the name after it has
# left the netboot environment and do whatever it wants with it.

#This script is probably unecessary and should be rolled
#into the get-name script.


MAC=`/usr/sbin/networksetup -getmacaddress Wi-Fi | awk ' { print $3; }' | sed -e s/://g `
cp "/opt/kace/petemp/${MAC}" "${KACE_SYSTEM_DRIVE_PATH}/Users/Shared/${MAC}"
rm -f "/opt/kace/petemp/${MAC}"