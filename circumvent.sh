#!/bin/bash

# Outputs our list of networks
# sudo iwlist wlan0 scan

#All info
Info=$(sudo iwlist wlan0 scan)
MACAddresses=$(sudo iwlist wlan0 scan | grep Address | sed s/Cell\ [0-9]*\ \-\ Address\:\ //)
SSIDs=$(sudo iwlist wlan0 scan | grep ESSID | sed s/ESSID\:// | sed s/\"// | sed s/\"//)

echo Here are the list of wireless connections available
for s in $SSIDs
do
	echo $s
done
echo Which would you like to connect to?

read chosenSSID
#verify available
#for s in $SSIDs
#do
#	if [ $s == $chosenSSID ];
#	then
#		echo 'found SSID'
#		verified='found'
#	fi
#done
#if [ -z "$verified" ]; #TODO expression doesn't work right now
#then
#	echo 'blah'
#else
#	echo 'Network not found, disconnecting'
#	exit
#fi

#TODO assign $MAC to corresponding MAC address from $MACAddresses

#configure before joining
  sudo iwconfig wlan0 $MAC #mac of router to join
  sudo iwconfig wlan0 essid $chosenSSID #name of network
  sudo iwconfig wlan0 freq 2.437
   
#connect!
   sudo dhclient wlan0
