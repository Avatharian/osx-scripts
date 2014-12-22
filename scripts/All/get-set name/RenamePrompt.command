#!/bin/bash

#This script is the second version of the Apply Name script. 
#It first checked for the existence of a name file from the previous scripts.
#If it finds one, it prompts the user with the found name.
#It then asks the user if they want to change the name.
#If it does not find a file, or the user selects Y, it asks the user for a new name
#then names the computer with that.
#If the user selects N (or any answer that is not Y, need to fix that), it exits.

#Special Note: When running from the K2000, in order to get a visible terminal
#window, this script must be saved as a .command file, and run from the K2000 with the command
#"open -W <script>.command"


SERIAL=`/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'`

TEMP_PATH="/Users/Shared/${SERIAL}"
if [ -f "${TEMP_PATH}" ] 
then
	computername=`cat ${TEMP_PATH}`
	echo "Computer name is going to be $computername"
	read -p "Is this Correct? Y/N " answer
	if [[ $answer =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		read -p "Enter Desired Name: " name
		scutil --set ComputerName $name
		newname=$(scutil --get ComputerName)
		echo "Computer Name is now: $newname"
		read -n1 -r -p "Press any key to continue..."
		killall Terminal
	else
		scutil --set ComputerName $computername
		scutil --set HostName $computername
		scutil --set LocalHostName $computername
		newname=$(scutil --get ComputerName)
		echo "Reading Computer Name: $newname"
		read -n1 -r -p "Press any key to continue..."
		killall Terminal
	fi
else
	computername="Not Found"
	echo "Computer name field was $computername"
	read -p "Do you want to Change? Y/N " answer
	if [[ $answer =~ ^([yY][eE][sS]|[yY])$ ]]
	then
		read -p "Enter Desired Name: " name
		scutil --set ComputerName $name
		newname=$(scutil --get ComputerName)
		echo "Computer Name is now: $newname"
		read -n1 -r -p "Press any key to continue..."
		killall Terminal
	else
		killall Terminal
	fi
fi