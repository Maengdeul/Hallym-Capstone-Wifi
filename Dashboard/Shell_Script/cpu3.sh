#!/bin/bash

#List of devices connected to openWRT2

	# get data from remote machine
	value=`ssh -p 12333 root@192.168.31.86 top -n 1 | head -2 | tail -1`
	usr=`echo $value | cut -d' ' -f4 | sed 's/[^0-9]//g'`
	sys=`echo $value | cut -d' ' -f6 | sed 's/[^0-9]//g'`
	idle=`echo $value | cut -d' ' -f10 | sed 's/[^0-9]//g'`
	time=`date '+%Y %m %d %H %M %S'`
	
	# insert data into db
 	echo "INSERT INTO cpu3 ( usr, sys, idle ) VALUE( $usr, $sys, $idle);" | mysql -uwimon -pWiMon wimon
	sleep 1

	# read data from MySQL, and print to the terminal
	echo "$time $usr $sys $idle" >> cpuvalue3.txt

	#data average
	usr_average=`cat cpuvalue3.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$7;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	sys_average=`cat cpuvalue3.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$8;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	idle_average=`cat cpuvalue3.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$9;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	
	#average print to the terminal
	echo "$time $usr_average $sys_average $idle_average" >> cpu_average3.txt
	#echo "$time $value $usr_average $sys_average $idle_average" >> cpu_average3.txt
	
	#file copy and move
	sudo cp cpuvalue3.txt /var/www/html/cpu3.txt
	sudo cp cpu_average3.txt /var/www/html/cpu_averagevalue3.txt	

