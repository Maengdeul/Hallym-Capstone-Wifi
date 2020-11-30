#!/bin/bash

#Get the RX and TX values of openWRT1 

while : 
do
	# get data from remote machine
	net1=`ssh wimon@210.115.229.76 ifconfig eno1 | grep "RX packets"; `
	net2=`ssh wimon@210.115.229.76 ifconfig eno1 | grep "TX packets";`
	RX=`echo $net1 | cut -d' ' -f5`
	TX=`echo $net2 | cut -d' ' -f5`
	time=`date '+%Y %m %d %H %M %S'`

	#print to the terminal
	echo "$time $RX $TX" >> netvalue.txt

	#average and print to the terminal
	RX_average=`cat netvalue.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$7;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	TX_average=`cat netvalue.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$8;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	echo "$time $RX_average $TX_average" >> net_average.txt

	# insert data into db
	echo "INSERT INTO net ( RX, TX ) VALUE( $RX, $TX );" | mysql -uwimon -pWiMon wimon
	sleep 1
		
	#file move
	filecp=`sudo cp netvalue.txt net.txt`
	filecp_average=`sudo cp net_average.txt net_averagevalue.txt`
	filemv=`sudo mv net.txt /var/www/html`
	filemv_average=`sudo mv net_averagevalue.txt /var/www/html`	
	sleep 2
done
