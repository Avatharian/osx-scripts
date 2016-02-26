#!/bin/bash

# Created 2016/02/16 jason@caudle.io

# Default behavior is Get-Set name behavior which, when used with the
# appropriate companion scripts, carries a computer name over from a computer
# from before it was imaged. setting Parameter 4 in Casper Imaging to TRUE
# enables WSName-style behavior. The script checks the supplied path for a list
# of names and serial numbers.

# Note: Script is designed for use with Casper Imaging. --uselist is Parameter
# $4. File path is Paramter $5. The script kills jamfHelper so you can see the
# dialog boxes. 

# DEPENDENCIES: CocoaDialog 3.0 beta https://mstratman.github.io/cocoadialog/
# Install in /Application/Utilities

# Get-Set name functions require: getComputerName.sh - run as pre-image task
# copyComputerName.sh - run as post-image, pre-reboot task


# TODO: Come up with a way to make this work properly with Target Mode imaging.
# Will need to read some other unique identifier from the target machine. Or
# perhaps not, May just be able to use a known filename for the namefile
# instead. Target Mode imaging won't overwrite it unlike netbooted machines.
#
# Also, change the script parameter setup to be a bit less dumb souding.




# Define initial variables
WSNAME=0

if [[ "$4" == "TRUE" ]]; then
	WSNAME=1
fi

cocoa="/Applications/Utilities/cocoaDialog.app/Contents/MacOS/cocoaDialog"
SERIAL=$(/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
TEMP_PATH="/Users/Shared/$SERIAL"
WSFILE="$5"
CASPER_FIRSTRUN="/Library/Application Support/JAMF/FirstRun/Enroll"

# Function definitions. These will be the various Cocoa dialogs

CocoaShowName () {
	rv=$($cocoa yesno-msgbox --title "Confirm Computer Name" --text "Computer Name will be set to $1. Is this correct?" --icon "computer" --no-cancel --float --no-newline --width 600 --height 120)
	if [[ $rv == 1 ]]; then
		return 0
	else
		return 1
	fi
}

CocoaAskName () {
	newName=$($cocoa inputbox --title "Enter Computer Name" --informative-text "Computer name is currently: $1" --button1 "Ok" --float --no-newline | tail -n1)
}

SetComputerName () {
	scutil --set ComputerName "$1"
	scutil --set HostName "$1"
	scutil --set LocalHostName "$1"
	name=$(scutil --get ComputerName)
	$cocoa msgbox --title "Complete" --icon "info" --text "Computer Name has been set to: $name" --float --button1 "Ok"
}

# LOGIC!

# Start with removing the Set Computer Name function from the Casper Imaging firstboot script. Unfortunately Capser
# imaging does not allow you to forgo naming a computer using it's built-in tool. 
grep -v "/usr/local/bin/jamf setComputerName" "$CASPER_FIRSTRUN/enroll.sh" > "$CASPER_FIRSTRUN/tempenroll.sh"; mv "$CASPER_FIRSTRUN/tempenroll.sh" "$CASPER_FIRSTRUN/enroll.sh"


# Kill JamfHelper so we can see our dialogs!
killall jamfHelper


if [[ $WSNAME == 0 ]]; then #Check for --uselist flag. 
	if [[ -f "$TEMP_PATH" ]]; then #if no --uselist, check for presence of the name transfer file
		computerName=$(cat "$TEMP_PATH") #if found, set computerName to it's contents
		if CocoaShowName "$computerName"; then #run CocoaShowName. If the user clicks yes, set Computer Name and exit!
			SetComputerName "$computerName"
		else #if the user clicks no, ask for the name then set the entered name as Computer Name, then exit.
			CocoaAskName "$computerName"
			SetComputerName "$newName"
		fi
	else
		CocoaAskName "Not Found"
		SetComputerName "$newName"
	fi
else
	if [[ -f "$WSFILE" ]]; then
		WSNAME=$(grep "$SERIAL" "$WSFILE" | awk '{ print $3 }')
		if CocoaShowName "$WSNAME"; then
			SetComputerName "$WSNAME"
		else
			CocoaAskName "WSNAME"
			SetComputerName "$newName"
		fi
	else
		CocoaAskName "Not Found"
		SetComputerName "$newName"
	fi
fi

exit 0

