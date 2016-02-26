#!/bin/bash
#Second step for name transfer. Copies the name file from the local drive to the target drive
SERIAL=$(/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
cp "/Users/Shared/$SERIAL" "$1/Users/Shared/${SERIAL}"
rm -f "/Users/Shared/$SERIAL"