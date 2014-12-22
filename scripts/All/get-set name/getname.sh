#!/bin/bash

##################################################################
#
# Paired with the Copy Name and one of the Apply Name scripts
# this script can be used to associate a host name with a mac address across 
# installs.  
#
# Hostname is saved as mac address in 
# $KACE_SYSTEM_DRIVE_NAME/Users/Shared/{MAC}
#
##################################################################
SERIAL=`/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'`

TEMP_PATH="/opt/kace/petemp/${SERIAL}"

IFS=$'\n'
volume=`mount | grep -m 1 disk0`
zeroMount=`echo "$volume" | awk  '{  print substr($0,index($0, "on ")+3,index($0, "(")-index($0, "on ")-4) }'`

prefPath=${KACE_SYSTEM_DRIVE_PATH}/Library/Preferences/SystemConfiguration/preferences.plist

tComputerName=`/usr/libexec/PlistBuddy -c "Print System:System:ComputerName" $prefPath` 
computerName=`echo $tComputerName | awk '{ print index($0,"Not Exist") }'`
fixMe="FIXME-$SERIAL"
if [x$computerName == x0 ]; then
   computerName=$tComputerName
else 
   computerName="$fixMe"
fi

echo $computerName > "${TEMP_PATH}"

cp "/opt/kace/petemp/${$SERIAL}" "${KACE_SYSTEM_DRIVE_PATH}/Users/Shared/${$SERIAL}"
rm -f "/opt/kace/petemp/${$SERIAL}"

exit 0