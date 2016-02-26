#!/bin/bash

##################################################################
#
# Paired with the Copy Name and one of the Apply Name scripts
# this script can be used to associate a host name with a Serial number across 
# installs.  

# Hostname is saved as Serial in 
# /Users/Shared/$SERIAL on the imaging host.
#
##################################################################


#Retrieves the system's serial number as variable $SERIAL
SERIAL=$(/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')

#Sets the TEMP_PATH variable to the folder on the K2000 where the computer name will be temporarily stored
TEMP_PATH="/Users/Shared/$SERIAL"

#setting the prefPath variable to target the machines original preferences.plist on it's local drive, in preparation to
#retrieve the old computer name
prefPath="$1/Library/Preferences/SystemConfiguration/preferences.plist"

#Reads the computers original name using plist buddy, and setting the tComputerName variable with it
tComputerName=$(/usr/libexec/PlistBuddy -c "Print System:System:ComputerName" "$prefPath")

#Tests to see if PlistBuddy found the required information. If it did not, computerName becomes something other than 0
computerName=$(echo "$tComputerName" | awk '{ print index($0,"Exist") }')

#sets the fixMe variable to concatenate "FIXME-" + the Serial Number of the machine
fixMe="FIXME-$SERIAL"

#if PlistBuddy didn't manage to pull a computer name, set computerName to the fixme string.
if [ x$computerName == x0 ]; then
   computerName="$tComputerName"
else 
   computerName="$fixMe"
fi

#Echoes the $computerName variable to the netboot environment, from which it will be copied to the client machine post-imaging
echo "$computerName" > "$TEMP_PATH"


exit 0