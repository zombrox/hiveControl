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

case $currentCoin in
     lyra2re)
let "stratumPort = $minersLocation+49000"
#echo $stratumPort

let "getworkPort = $minersLocation+50000"
#echo $getworkPort
;;
     lyra2rev2)
let "stratumPort = $minersLocation+51000"
#echo $stratumPort

let "getworkPort = $minersLocation+52000"
#echo $getworkPort
;;

     Cryptonit)
let "stratumPort = $minersLocation+53000"
#echo $stratumPort

let "getworkPort = $minersLocation+54000"
#echo $getworkPort
;;

esac

screen -dmS $screenName "$proxyLocation"stratum-mining-proxy/mining_proxy.py --host $poolAddr --port $poolPort --stratum-port $stratumPort --getwork-port $getworkPort -q
echo `ps -ef | grep SCREEN | grep $screenName | awk '! /awk/ && /'$minersLocation'/ {print $2}'` > '/tmp/'$screenName'Pid'
