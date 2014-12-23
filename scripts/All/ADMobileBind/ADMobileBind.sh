#!/bin/sh
#Domain Variables
DOMAIN="Enter Domain"
DOMAINUSER="Enter Domain Admin here"
DOMAINPASSWORD="Enter Domain Password"
LOCALUSER="Enter Local Admin"
LOCALPASSWORD="Local Admin Passowrd"
OU="AD OU to place the computer in"
#
dsconfigad -force -add $DOMAIN -username $DOMAINUSER -password $DOMAINPASSWORD -localuser $LOCALUSER -localpassword $LOCALPASSWORD -ou $OU -force
dsconfigad -mobile enable -mobileconfirm disable -localhome enable -groups "domain admins,enterprise admins" -useuncpath enable -sharepoint enable
touch /.kaceMobileBindingDone