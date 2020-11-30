#!/bin/bash

#Execute four mem.sh at once.

while :
do
	# start mem1.sh
	/home/wimon/mem1.sh

	#start mem2.sh
	/home/wimon/mem2.sh
	
	#start mem3.sh
	/home/wimon/mem3.sh
	
	#start mem4.sh
	/home/wimon/mem4.sh

	sleep 3

done 
