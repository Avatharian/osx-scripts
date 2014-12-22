#!/bin/bash

#This version of the Apply script automatically takes the now copied 
#mac address/name file and applies it to the computer automatically.

#There is another version of this script that will prompt for response first.


SERIAL=`/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'`

TEMP_PATH="/Users/Shared/${SERIAL}"
if [ -f "${TEMP_PATH}" ] 
then
	computername=`cat ${TEMP_PATH}`
	scutil --set ComputerName $computername
	scutil --set HostName $computername
	scutil --set LocalHostName $computername
else
exit 5
fi