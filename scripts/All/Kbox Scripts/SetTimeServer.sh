if [ -f /Users/Shared/timeset ]; then
	logger SetTimeServer: Time already set, or at least timeset file already exists.
else
	systemsetup -setnetworktimeserver 10.0.10.5
	echo "server time.apple.com" >> /etc/ntp.conf
	touch /Users/Shared/timeset
fi