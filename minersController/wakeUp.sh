#!/bin/bash
minersLocation=$1
#controllerLocation='/root/hiveControl/'
controllerLocation='../'

echo "#" > shutDownList$minersLocation.txt

while read line; do
	if [ "$line" = "${line%#*}" -a "$line" ]; then
	pingHost=`echo $line | sed -e 's/\;/ /g' | awk '{print $1}'`
	adminUser=`echo $line | sed -e 's/\;/ /g' | awk '{print $3}'`
	adminPass=`echo $line | sed -e 's/\;/ /g' | awk '{print $4}'`

	ping -w 1 -c 1 $pingHost >/dev/null 2>&1 && echo " " || \
		(echo "$pingHost;$adminUser;$adminPass" >> shutDownList$minersLocation.txt && \
		wakeHost=`echo $line | sed -e 's/\;/ /g' | awk '{print $2}'` &&\
		echo "wakeonline $wakeHost")
	fi
done < hosts$minersLocation.txt

#	adminUser=`echo $line | sed -e 's/\;/ /' | awk '{print $3}'`
#	adminPass=`echo $line | sed -e 's/\;/ /' | awk '{print $4}'`
