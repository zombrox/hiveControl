#!/bin/bash
minersLocation=$1
controllerLocation='/root/hiveControl/'

while read line; do
	if [ "$line" = "${line%#*}" -a "$line" ]; then
	shutDownHost=`echo $line | sed -e 's/\;/ /g' | awk '{print $1}'`
	adminUser=`echo $line | sed -e 's/\;/ /g' | awk '{print $2}'`
	adminPass=`echo $line | sed -e 's/\;/ /g' | awk '{print $3}'`
	net rpc shutdown -I $shutDownHost -U $adminUser%$adminPass
	fi
done < "$controllerLocation"minersController/shutDownList$minersLocation.txt

rm "$controllerLocation"minersController/shutDownList$minersLocation.txt

