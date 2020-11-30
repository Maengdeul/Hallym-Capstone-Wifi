#!/bin/bash

#Check openWRT3 memory status

	# get data from remote machine
	mem=`ssh -p 12333 root@192.168.31.86 free -m | head -2 | tail -1 | awk '{print $2,$3}'`
	total=`echo $mem | cut -d' ' -f1 | sed 's/[^0-9]//g'` 
	used=`echo $mem | cut -d' ' -f2 | sed 's/[^0-9]//g'`
	time=`date '+%Y %m %d %H %M %S'`

	#print to the terminal
	echo "$time $total $used" >> memvalue3.txt

	#total, used average and print to the terminal
	total_average=`cat memvalue3.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$7;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	used_average=`cat memvalue3.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$8;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`	
	echo "$time $total_average $used_average" >> mem_average3.txt
	
	# insert data into db
	echo "INSERT INTO mem3 ( total, used ) VALUE( '$total', '$used' );" | mysql -uwimon -pWiMon wimon
	sleep 1
	
	#file copy and move
	sudo cp memvalue3.txt /var/www/html/mem3.txt
	sudo cp mem_average3.txt /var/www/html/mem_averagevalue3.txt	
	

