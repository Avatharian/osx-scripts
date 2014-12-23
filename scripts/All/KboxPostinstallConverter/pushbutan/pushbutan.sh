#!/bin/sh
echo "PUSH BUTAN, SHOT WEB"
#delete the loginhook
/usr/bin/defaults delete com.apple.loginwindow LoginHook
#launch LoginLog
Library/Scripts/LoginLog.app/Contents/MacOS/LoginLog -logfile /tmp/outfile
#launch the postinstall task engine
sh /var/kace/k2000/system_image*.sh