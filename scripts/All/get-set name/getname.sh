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


#Retrieves the system's serial number as variable $SERIAL
SERIAL=`/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'`

#Sets the TEMP_PATH variable to the fodler on the K2000 where the computer name will be temporarily stored
TEMP_PATH="/opt/kace/petemp/${SERIAL}"

#setting the prefPath variable to target the machines original preferences.plist on it's local drive, in preparation to
#retrieve the old computer name
prefPath=${KACE_SYSTEM_DRIVE_PATH}/Library/Preferences/SystemConfiguration/preferences.plist

#Reads the computers original name using plist buddy, and setting the tComputerName variable with it
tComputerName=`/usr/libexec/PlistBuddy -c "Print System:System:ComputerName" $prefPath` 

#Ok. This will set the ComputerName variable to equal the tComputername variable IF the tComputername contains "Not Exist".
#I think. Otherwise this line does nothing, and basically sets the computerName varible to Null.
computerName=`echo $tComputerName | awk '{ print index($0,"Not Exist") }'`

#sets the fixMe variable to concatenate "FIXME-" + the Serial Number of the machine
fixMe="FIXME-$SERIAL"

#If the $computerName varibale is equal to x0 (in other words, did the previous step set it to Nthing), 
#that means that a name was in fact found, and the $computerName variable should be set to it.
#Otherwise, fallback on the FIXME+Serial Number name
if [ x$computerName==x0 ]; then
   computerName=$tComputerName
else 
   computerName="$fixMe"
fi

#Echoes the $computerName variable to the KACE network share, from which it will be copied to the client machine post-imaging
echo $computerName > "/opt/kace/petemp/${SERIAL}"


exit 0