#!/bin/bash
minersLocation=$1
controllerLocation='/root/hiveControl/'

currentCoin=`cat "$controllerLocation"proxyController/currentCoin.txt | sed -e '/^#/ d'`
#echo $currentCoin

screenName=`echo $minersLocation$currentCoin`
#echo $screenName


kill `cat '/tmp/'$screenName'Pid'`
