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
MAC=`/usr/sbin/networksetup -getmacaddress Wi-Fi | awk ' { print $3; }' | sed -e s/://g `

TEMP_PATH="/opt/kace/petemp/${MAC}"

IFS=$'\n'
volume=`mount | grep -m 1 disk0`
zeroMount=`echo "$volume" | awk  '{  print substr($0,index($0, "on ")+3,index($0, "(")-index($0, "on ")-4) }'`

prefPath=${KACE_SYSTEM_DRIVE_PATH}/Library/Preferences/SystemConfiguration/preferences.plist

tComputerName=`/usr/libexec/PlistBuddy -c "Print System:System:ComputerName" $prefPath` 
computerName=`echo $tComputerName | awk '{ print index($0,"Not Exist") }'`
if [ x$computerName == x0 ]; then
   computerName=$tComputerName
else 
   computerName="localhost"
fi

echo $computerName > "${TEMP_PATH}"

exit 0