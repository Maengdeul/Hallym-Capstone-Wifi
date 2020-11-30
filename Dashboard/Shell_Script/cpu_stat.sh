#!/bin/bash

#Run four cpu.sh at a time.

while :
do
	# start cpu.sh
	/home/wimon/cpu.sh

	#start cpu2.sh
	/home/wimon/cpu2.sh
	
	#start cpu3.sh
	/home/wimon/cpu3.sh
	
	#start cpu4.sh
	/home/wimon/cpu4.sh

	sleep 3

done 
