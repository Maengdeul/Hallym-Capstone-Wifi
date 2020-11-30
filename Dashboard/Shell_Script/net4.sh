#!/bin/bash

#Get the RX and TX values of openWRT4

	# get data from remote machine
	net1=`ssh root@192.168.31.80 -p 12334 ifconfig wlan0 | grep "RX packets"; `
	net2=`ssh root@192.168.31.80 -p 12334 ifconfig wlan0 | grep "TX packets";`
	RX=`echo $net1 | cut -d' ' -f2 | sed 's/[^0-9]//g'`
	TX=`echo $net2 | cut -d' ' -f2 | sed 's/[^0-9]//g'`	
	time=`date '+%Y %m %d %H %M %S'`

	#print to the terminal
	echo "$time $RX $TX" >> netvalue4.txt

	#average and print to the terminal
	RX_average=`cat netvalue4.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$7;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	TX_average=`cat netvalue4.txt | awk -F " " 'BEGIN{TOTAL=0;COUNT=0}{TOTAL+=$8;COUNT+=1.0}END{printf"%.3f \n",TOTAL/COUNT}'`
	echo "$time $RX_average $TX_average" >> net_average4.txt

	# insert data into db
	echo "INSERT INTO net4 ( RX, TX ) VALUE( $RX, $TX );" | mysql -uwimon -pWiMon wimon
		
	#file copy and move
	sudo cp netvalue4.txt /var/www/html/net4.txt
	sudo cp net_average4.txt /var/www/html/net_averagevalue4.txt	

