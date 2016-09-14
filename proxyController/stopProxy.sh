#!/bin/bash
proxyLocation=$1

currentCoin=`cat currentCoin.txt | sed -e '/^#/ d'`
echo $currentCoin

screenName=`echo $proxyLocation$currentCoin`
echo $screenName


kill `cat '/tmp/'$screenName'Pid'`
