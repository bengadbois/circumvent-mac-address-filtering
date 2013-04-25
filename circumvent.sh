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
    echo "This script must be run with root permissions"
    exit ${?}
fi


#get the mac address of the router given the SSID
echo "Finding the mac address of the router..."
routerAddr=`tcpdump -Ie -i $Interface -l -c 100 2> /dev/null \
    | grep "$SSID" \
    | sed s/.*BSSID:// \
    | sed s/\ \(.*//  \
    | head -n1`
echo $routerAddr

#sniff for a valid MAC
# I flag for promisc and e for mac addresses
# grep for our network ssid then ignore beacons
echo "Starting listening for a MAC address to spoof"
MAC=`tcpdump -i $Interface -e -c 5 udp 2> /dev/null \
    | sed s/\ \(oui.*// \
    | sed s/.*\ // \
    | head -n5`
echo $MAC

echo "If the mac address is the same as the routers run this script again"

#spoof the mac from above
ifconfig $Interface down hw ether $MAC
ifconfig $Interface up

echo "Changed your mac address!"
