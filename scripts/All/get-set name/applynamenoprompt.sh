#!/bin/bash

#This version of the Apply script automatically takes the now copied 
#mac address/name file and applies it to the computer automatically.

#There is another version of this script that will prompt for response first.


MAC=`/usr/sbin/networksetup -getmacaddress Wi-Fi | awk ' { print $3; }' | sed -e s/://g `

TEMP_PATH="/Users/Shared/${MAC}"
if [ -f "${TEMP_PATH}" ] 
then
	computername=`cat ${TEMP_PATH}`
	scutil --set ComputerName $computername
	scutil --set HostName $computername
	scutil --set LocalHostName $computername
else
exit 5
fi