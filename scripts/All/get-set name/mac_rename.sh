#/bin/bash

#This is a script that just uses a text database in the format of
#
# <MACADDRESS1> = <COMPUTERNAME1>
# <MACADDRESS2> = <COMPUTERNAME2>
# etc...
#
#to rename computers. Best for renaming all the new computers that I know I have the mac
#addresses for.


SERIAL=`/usr/sbin/system_profiler SPHardwareDataType | grep  'Serial Number' | awk '{ print $4 }' `
COMPNAME=`cat ./mac_names.txt | grep ${SERIAL} | awk '{ print $3 }' `


`/usr/sbin/scutil --set ComputerName ${COMPNAME} `
`/usr/sbin/scutil --set LocalHostName ${COMPNAME} `
`/usr/sbin/scutil --set HostName ${COMPNAME} `

#Hostname can be ${COMPNAME} or ${COMPNAME}.kace.com