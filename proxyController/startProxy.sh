#!/bin/bash
minersLocation=$1
proxyLocation="/root/"
controllerLocation='/root/hiveControl/'


currentCoin=`cat "$controllerLocation"proxyController/currentCoin.txt | sed -e '/^#/ d'`
#echo $currentCoin

screenName=`echo $minersLocation$currentCoin`
#echo $screenName

poolAddr=`cat "$controllerLocation"proxyController/currentPool.txt | sed -e '/^#/ d'| sed -e 's/\:/ /' | awk '{print $1}'`
#echo $poolAddr

poolPort=`cat "$controllerLocation"proxyController/currentPool.txt | sed -e '/^#/ d'| sed -e 's/\:/ /' | awk '{print $2}'`
#echo $poolPort

currentUser=`cat "$controllerLocation"proxyController/currentUser.txt | sed -e '/^#/ d'| sed -e 's/\:/ /' | awk '{print $1}'`
#echo $currentUser

currentPassword=`cat "$controllerLocation"proxyController/currentUser.txt | sed -e '/^#/ d'| sed -e 's/\:/ /' | awk '{print $2}'`
#echo $currentPassword

case $currentCoin in
     lyra2re)
let "stratumPort = $minersLocation+6000"
#echo $stratumPort

let "getworkPort = $minersLocation+7000"
#echo $getworkPort
;;
     lyra2rev2)
let "stratumPort = $minersLocation+8000"
#echo $stratumPort

let "getworkPort = $minersLocation+9000"
#echo $getworkPort
;;

     Cryptonit)
let "stratumPort = $minersLocation+10000"
#echo $stratumPort

let "getworkPort = $minersLocation+11000"
#echo $getworkPort
;;

esac


case $minersLocation in
	000)
	addParams="-cu $currentUser -cp $currentPassword"
#	echo $addParams
	;;

esac

screen -dmS $screenName "$proxyLocation"stratum-mining-proxy/mining_proxy.py --host $poolAddr --port $poolPort $addParams --stratum-port $stratumPort --getwork-port $getworkPort -q
echo `ps -ef | grep SCREEN | grep $screenName | awk '! /awk/ && /'$minersLocation'/ {print $2}'` > '/tmp/'$screenName'Pid'
