#!/bin/bash

#All info
if [ $# -lt 2 ];
then
	echo "Requires two arguments"
	echo "Arg1 the SSID of the network to connect to"
	echo "Arg2 the name of the wireless interface"
	exit
fi

#Check fori root
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
echo "Starting listening for 15s"
tcpdumpBin=`which tcpdump`
#TCPOUT=`tcpdump -Ie -i $2 -c 25 -n dst port 80`
echo $TCPOUT
echo \n
echo \n
echo \n
echo \n
echo \n
echo \n
echo \n
echo $TCPOUT # \
#    | grep "$1" #\
    #| grep -i "beacon" #| sed s/.*DA// | sed s/\ *// 
echo "Finished Listening"
# TODO get the DA field
echo $MAC
#spoof the mac from above
#TODO might have to edit /etc/networks/interface
#sudo ifconfig $2 down hw ether $MAC
#sudo ifconfig $2 up
echo "Changed your mac address!"

# join the ssid
#iwconfig $2 essid $1

#dhclient $2

#ping to verify connected, otherwise goto picking a new MAC

