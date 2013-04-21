#!/bin/bash

# Outputs our list of networks
# sudo iwlist wlan0 scan

#All info
if [ $# -lt 2 ];
then
	echo "Requires two arguments"
	echo "Arg1 the SSID of the network to connect to"
	echo "Arg2 the name of the wireless interface"
	exit
fi

#sniff for a valid MAC
# I flag for promisc and e for mac addresses
# grep for our network ssid then ignore beacons
sudo tcpdump -Ie -i $2 | grep "$1" | grep -i -v "beacon"

# join the ssid
sudo iwconfig $2 essid $1

#sudo iwconfig $2 $MAC #mac of router to join

#sudo dhclient $2

#ping to verify connected, otherwise goto picking a new MAC


#Info=$(sudo iwlist wlan0 scan)
#MACAddresses=$(sudo iwlist wlan0 scan essid $1 | grep Address | sed s/Cell\ [0-9]*\ \-\ Address\:\ //)
#MAC=${MACAddresses[@]} | sed s/\ *//
#echo "THE MAC IS " $MAC

#configure before joining
#  sudo iwconfig wlan0 $MAC #mac of router to join
#  sudo iwconfig wlan0 essid $1 #name of network
#  sudo iwconfig wlan0 freq 2.437 #TODO can probably remove
   
#connect!
#   sudo dhclient wlan0
