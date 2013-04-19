#!/bin/bash

# Outputs our list of networks
# sudo iwlist wlan0 scan

#All info
if [ $# -eq 0 ];
then
	echo Requires one argument as the SSID of the wireless network to connect to
	exit
fi


sudo iwconfig wlan0 essid $1

#TODO sniff for a valid MAC

sudo iwconfig wlan0 $MAC #mac of router to join

sudo dhclient wlan0

#ping to verify connected, otherwise goto picking a new MAC


#Info=$(sudo iwlist wlan0 scan)
MACAddresses=$(sudo iwlist wlan0 scan essid $1 | grep Address | sed s/Cell\ [0-9]*\ \-\ Address\:\ //)
MAC=${MACAddresses[@]} | sed s/\ *//
echo "THE MAC IS " $MAC

#configure before joining
  sudo iwconfig wlan0 $MAC #mac of router to join
  sudo iwconfig wlan0 essid $1 #name of network
  sudo iwconfig wlan0 freq 2.437 #TODO can probably remove
   
#connect!
   sudo dhclient wlan0
