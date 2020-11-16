#!/bin/bash

# how to use
# 1) ./get-renite-data.sh > file.txt
# 2) read file.txt in the xxx.html 
# 3) use the data from file.txt to draw charts 

while :
do
	# get data from remote machine
	value=`ssh wimon@210.115.229.76 mpstat 1 2 | tail -2 | head -1 | awk '{print $4,$6,$13}' `
	usr=`echo $value | cut -d' ' -f1`
	sys=`echo $value | cut -d' ' -f2`
	idle=`echo $value | cut -d' ' -f3` 
	time=`date '+%Y %m %d %H %M %S'`

	# insert data into db
 	echo "INSERT INTO wimon ( usr, sys, idle ) VALUE( $usr, $sys, $idle);" | mysql -uwimon -pWiMon wimon
	sleep 1

	# read data from MySQL, and print to the terminal
	echo "$time $value" >> cpuvalue.txt

	#data average
	usr_average=`cat cpuvalue.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$7;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	sys_average=`cat cpuvalue.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$8;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	idle_average=`cat cpuvalue.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$9;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	
	#average print to the terminal
	echo "$time $usr_average $sys_average $idle_average" >> cpu_average.txt
	#echo "$time $value $usr_average $sys_average $idle_average" >> cpu_average.txt

	#file move
	filecp=`sudo cp cpuvalue.txt cpu.txt`
	avergaefilecp=`sudo cp cpu_average.txt cpu_averagevalue.txt`
	filemv=`sudo mv cpu.txt /var/www/html`
	filemv_avergae=`sudo mv cpu_averagevalue.txt /var/www/html`	

	# echo ...
	#sleep 2
done

