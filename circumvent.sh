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

#sniff for a valid MAC
# I flag for promisc and e for mac addresses
# grep for our network ssid then ignore beacons
echo "Starting listening for a MAC address to spoof"
tcpdumpBin=`which tcpdump`
TCPOUT=`tcpdump -Ie -i $Interface -c 25 -n dst port 80`
echo $TCPOUT # \
#    | grep "$1" #\
    #| grep -i "beacon" #| sed s/.*DA// | sed s/\ *// 
echo "Finished Listening"
# TODO get the DA field

#spoof the mac from above
sudo ifconfig $Interface down hw ether $MAC #need to bring network down to configure
sudo ifconfig $Interface up
echo "Changed your mac address!"
