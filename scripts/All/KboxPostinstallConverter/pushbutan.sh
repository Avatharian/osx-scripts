#!/bin/sh
echo "PUSH BUTAN, SHOT WEB"
#delete the loginhook
/usr/bin/defaults delete com.apple.loginwindow LoginHook
#launch the postinstall task engine
sh /var/kace/k2000/system_image*.sh