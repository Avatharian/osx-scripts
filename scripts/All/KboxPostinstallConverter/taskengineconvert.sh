#!/bin/sh

#This script converts the K2000's dumb loginhook implementation into a proper LaunchD.

#Install the launchd and the script which launches the K2000 task engine and the LoginLog.app
cp ./cc.valdez.taskengine.plist "$KACE_SYSTEM_DRIVE_PATH/Library/LaunchDaemons/cc.valdez.taskengine.plist"
chown root "$KACE_SYSTEM_DRIVE_PATH/Library/LaunchDaemons/cc.valdez.taskengine.plist"
chmod 644 "$KACE_SYSTEM_DRIVE_PATH/Library/LaunchDaemons/cc.valdez.taskengine.plist"

cp ./pushbutan.sh "$KACE_SYSTEM_DRIVE_PATH/Library/Scripts/pushbutan.sh"
chown root "$KACE_SYSTEM_DRIVE_PATH/Library/Scripts/pushbutan.sh"
chmod 744 "$KACE_SYSTEM_DRIVE_PATH/Library/Scripts/pushbutan.sh"

cp ./cc.valdez.loginlog.plist "$KACE_SYSTEM_DRIVE_PATH/Library/LaunchDaemons/cc.valdez.loginlog.plist"
chown root "$KACE_SYSTEM_DRIVE_PATH/Library/LaunchDaemons/cc.valdez.loginlog.plist"
chmod 644 "$KACE_SYSTEM_DRIVE_PATH/Library/LaunchDaemons/cc.valdez.loginlog.plist"

cp -r ./LoginLog.app "$KACE_SYSTEM_DRIVE_PATH/Library/Scripts/LoginLog.app"
chown -R root "$KACE_SYSTEM_DRIVE_PATH/Library/Scripts/LoginLog.app"
chmod -R 744 "$KACE_SYSTEM_DRIVE_PATH/Library/Scripts/LoginLog.app"