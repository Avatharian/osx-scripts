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

#Dear god nested if statements.
SERIAL=`/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'`
TEMP_PATH="/Users/Shared/${SERIAL}"
if [ -f "${TEMP_PATH}" ] 
then
	computername=`cat ${TEMP_PATH}`
	if [[ $computername !== *"FIXME"* ]]
		then
			while true; do
				echo "Computer name is $computername"
				read -p "Is this correct? Y/N " answer
				if [[ $answer =~ ^([nN][oO]|[nN])$ ]]
					then
						while true; do
							read -p "Enter Desired Name: " name
							read -p "Please reenter to confirm: " name2
							if [ $name == $name2 ]
								then
									scutil --set ComputerName $name
									scutil --set HostName $name
									scutil --set LocalHostName $name
									newname=$(scutil --get ComputerName)
									echo "Computer Name is now: $newname"
									read -n1 -r -p "Press any key to continue..."
									killall Terminal
							else
								continue
							fi
						done
				elif [[ $answer =~ ^([yY][eE][sS]|[yY])$ ]]
					then
						scutil --set ComputerName $computername
						scutil --set HostName $computername
						scutil --set LocalHostName $computername
						newname=$(scutil --get ComputerName)
						echo "Reading Computer Name: $newname"
						read -n1 -r -p "Press any key to continue..."
						killall Terminal
				fi
			done
	else
		echo "Warning! FIXME Name Detected!"
		echo "Computer Name is $computername"
		while true; do
			read -p "Please Enter a proper name: " name
			read -p "Please reenter to confirm: " name2
			if [ $name == $name2 ]
				then
					scutil --set ComputerName $name
					scutil --set HostName $name
					scutil --set LocalHostName $name
					newname=$(scutil --get ComputerName)
					echo "Computer Name is now: $newname"
					read -n1 -r -p "Press any key to continue..."
					killall Terminal
			else
				continue
			fi
		done
	fi
else
	computername="not Found"
	echo "Computer name file was $computername"
	while true; do
		read -p "Please enter a proper name: " name
		read -p "Please reenter to confirm: " name2
		if [ $name == $name2 ]
			then
				scutil --set ComputerName $name
				newname=$(scutil --get ComputerName)
				echo "Computer Name is now: $newname"
				read -n1 -r -p "Press any key to continue..."
				killall Terminal
		else
			continue
		fi
	done
fi