#!/bin/bash

#Run all shell at once.

while :
do
	echo "cpu start"
	# start cpu.sh
	/home/wimon/cpu.sh
	#start cpu2.sh
	/home/wimon/cpu2.sh
	#start cpu3.sh
	/home/wimon/cpu3.sh
	#start cpu4.sh
	/home/wimon/cpu4.sh

	echo "mem start"
	# start mem1.sh
	/home/wimon/mem1.sh

	#start mem2.sh
	/home/wimon/mem2.sh
	
	#start mem3.sh
	/home/wimon/mem3.sh
	
	#start mem4.sh
	/home/wimon/mem4.sh

	echo "net start"
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
