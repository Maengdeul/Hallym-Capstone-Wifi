#!/bin/bash


while :
do
	# get data from remote machine
	mem=`ssh wimon@210.115.229.76 free -m | head -2 | tail -1 | awk '{print $2,$3}'`
	total=`echo $mem | cut -d' ' -f1 | sed 's/[^0-9]//g'` 
	used=`echo $mem | cut -d' ' -f2 | sed 's/[^0-9]//g'`
	time=`date '+%Y %m %d %H %M %S'`

	#print to the terminal
	echo "$time $total $used" >> memvalue.txt

	#total, used average and print to the terminal
	total_average=`cat memvalue.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$7;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	used_average=`cat memvalue.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$8;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`	
	echo "$time $total_average $used_average" >> mem_average.txt
	
	# insert data into db
	echo "INSERT INTO mem ( total, used ) VALUE( '$total', '$used' );" | mysql -uwimon -pWiMon wimon
	sleep 1
	
	#file move
	filecp=`sudo cp memvalue.txt mem.txt`
	filecp_average=`sudo cp mem_average.txt mem_averagevalue.txt`
	filemv=`sudo mv mem.txt /var/www/html`
	filemv_average=`sudo mv mem_averagevalue.txt /var/www/html`	
	sleep 2
done

