#!/bin/bash

#Execute four mem.sh at once.

while :
do
	# start net1.sh
	/home/wimon/net1.sh

	#start net2.sh
	/home/wimon/net2.sh
	
	#start net3.sh
	/home/wimon/net3.sh
	
	#start net4.sh
	/home/wimon/net4.sh

	sleep 3

done 
