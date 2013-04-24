#!/bin/bash

#All info
if [ $# -lt 2 ];
then
	echo "Requires two arguments"
	echo "Arg1 the SSID of the network to connect to"
	echo "Arg2 the name of the wireless interface"
	exit
fi

SSID=$1
Interface=$2

#Check for root access
if [ ! $( id -u ) -eq 0 ]; then
    echo "Please enter root's password"
    exec sudo "${Base}/${0}  ${CMDLN_ARGS}" # Call this prog as root
    exit ${?}
fi


#get the mac address of the router given the SSID
echo "Finding the mac address of the router..."
routerAddr=`tcpdump -Ie -i $2 -l -c 100 2> /dev/null | grep "$1" | sed s/.*BSSID:// | sed s/\ \(.*//  | head -n1`
echo $routerAddr

#sniff for a valid MAC
# I flag for promisc and e for mac addresses
# grep for our network ssid then ignore beacons
echo "Starting listening for a MAC address to spoof"

# TODO get the DA field

#spoof the mac from above
sudo ifconfig $2 down hw ether $MAC
sudo ifconfig $2 up

echo "Changed your mac address!"
