#!/bin/bash
proxyLocation=$1

currentCoin=`cat currentCoin.txt | sed -e '/^#/ d'`
#echo $currentCoin

screenName=`echo $proxyLocation$currentCoin`
#echo $screenName

poolAddr=`cat currentPool.txt | sed -e '/^#/ d'| sed -e 's/\:/ /' | awk '{print $1}'`
#echo $poolAddr

poolPort=`cat currentPool.txt | sed -e '/^#/ d'| sed -e 's/\:/ /' | awk '{print $2}'`
#echo $poolPort

case $currentCoin in
     lyra2re)
let "stratumPort = $proxyLocation+49000"
#echo $stratumPort

let "getworkPort = $proxyLocation+50000"
#echo $getworkPort
;;
     lyra2rev2)
let "stratumPort = $proxyLocation+51000"
#echo $stratumPort

let "getworkPort = $proxyLocation+52000"
#echo $getworkPort
;;

     Cryptonit)
let "stratumPort = $proxyLocation+53000"
#echo $stratumPort

let "getworkPort = $proxyLocation+54000"
#echo $getworkPort
;;

esac


screen -dmS $screenName /scripts/quark-stratum-mining-proxy/mining_proxy.py --host $poolAddr --port $poolPort --stratum-port $stratumPort --getwork-port $getworkPort -q
echo `ps -ef | grep SCREEN | grep $screenName | awk '! /awk/ && /night/ {print $2}'` > '/tmp/'$screenName'Pid'
