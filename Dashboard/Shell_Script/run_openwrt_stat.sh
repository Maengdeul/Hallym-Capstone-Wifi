#!/bin/bash

while :
do
	#OpenWRT1
	#get data from remote machine and print to the terminal
	ssh root@211.210.92.69 /etc/config/openwrt_stat.sh > openwrt1.txt 2>&1
	
	if test -f "openwrt1.txt"; then
		openwrt1=$(<openwrt1.txt)
		# insert data into db
		while read line; do
			equipment=$line
			ip_address=`echo $equipment | cut -d' ' -f1`  
			name=`echo $equipment | cut -d' ' -f2` 
			mac_address=`echo $equipment | cut -d' ' -f3` 
			rx=`echo $equipment | cut -d' ' -f4` 
			tx=`echo $equipment | cut -d' ' -f6`  
			rx_bytes=`echo $equipment | cut -d' ' -f8` 
			rx_packets=`echo $equipment | cut -d' ' -f9` 
			tx_bytes=`echo $equipment | cut -d' ' -f10` 
			tx_packets=`echo $equipment | cut -d' ' -f11` 
			Expected_throughput=`echo $equipment | cut -d' ' -f12`  
	
			echo "INSERT INTO OpenWRT1 VALUE ('$ip_address', '$name', '$mac_address', '$rx', '$tx', '$rx_bytes','$rx_packets', '$tx_bytes', '$tx_packets', '$Expected_throughput');" | mysql -uwimon -pWiMon wimon
		done < openwrt1.txt
	fi

	#OpenWRT2
	#get data from remote machine and print to the terminal
	ssh -p 1818 root@211.210.92.69 /etc/config/openwrt_stat.sh > openwrt2.txt  2>&1
	
	#연결된 목록이 없는 경우 DB에 출력하지 않는다.
	if test -f "openwrt1.txt"; then
		openwrt2=$(<openwrt2.txt)

		# insert data into db
		while read line; do
			equipment=$line
			ip_address=`echo $equipment | cut -d' ' -f1`  
			name=`echo $equipment | cut -d' ' -f2` 
			mac_address=`echo $equipment | cut -d' ' -f3` 
			rx=`echo $equipment | cut -d' ' -f4` 
			tx=`echo $equipment | cut -d' ' -f6`  
			rx_bytes=`echo $equipment | cut -d' ' -f8` 
			rx_packets=`echo $equipment | cut -d' ' -f9` 
			tx_bytes=`echo $equipment | cut -d' ' -f10` 
			tx_packets=`echo $equipment | cut -d' ' -f11` 
			Expected_throughput=`echo $equipment | cut -d' ' -f12`  
	
			echo "INSERT INTO OpenWRT2 VALUE ('$ip_address', '$name', '$mac_address', '$rx', '$tx', '$rx_bytes','$rx_packets', '$tx_bytes', '$tx_packets', '$Expected_throughput');" | mysql -uwimon -pWiMon wimon

		done < openwrt2.txt
	fi	

	#OpenWRT3
	#get data from remote machine and print to the terminal
	ssh root@116.42.53.54 -p12333 test/openwrt_stat.sh > openwrt3.txt  2>&1
		
	if test -f "openwrt1.txt"; then
		openwrt3=$(<openwrt3.txt)

		# insert data into db
		while read line; do
			equipment=$line
			ip_address=`echo $equipment | cut -d' ' -f1`  
			name=`echo $equipment | cut -d' ' -f2` 
			mac_address=`echo $equipment | cut -d' ' -f3` 
			rx=`echo $equipment | cut -d' ' -f4` 
			tx=`echo $equipment | cut -d' ' -f6`  
			rx_bytes=`echo $equipment | cut -d' ' -f8` 
			rx_packets=`echo $equipment | cut -d' ' -f9` 
			tx_bytes=`echo $equipment | cut -d' ' -f10` 
			tx_packets=`echo $equipment | cut -d' ' -f11` 
			Expected_throughput=`echo $equipment | cut -d' ' -f12`  
	
			echo "INSERT INTO OpenWRT3 VALUE ('$ip_address', '$name', '$mac_address', '$rx', '$tx', '$rx_bytes','$rx_packets', '$tx_bytes', '$tx_packets', '$Expected_throughput');" | mysql -uwimon -pWiMon wimon

		done < openwrt3.txt

	fi
	

	#OpenWRT4
	#get data from remote machine and print to the terminal
	ssh root@116.42.53.54 -p12334 test/openwrt_stat.sh > openwrt4.txt 2>&1
	
	if test -f "openwrt1.txt"; then
		openwrt4=$(<openwrt4.txt)

		# insert data into db
		while read line; do
			equipment=$line
			ip_address=`echo $equipment | cut -d' ' -f1`  
			name=`echo $equipment | cut -d' ' -f2` 
			mac_address=`echo $equipment | cut -d' ' -f3` 
			rx=`echo $equipment | cut -d' ' -f4` 
			tx=`echo $equipment | cut -d' ' -f6`  
			rx_bytes=`echo $equipment | cut -d' ' -f8` 
			rx_packets=`echo $equipment | cut -d' ' -f9` 
			tx_bytes=`echo $equipment | cut -d' ' -f10` 
			tx_packets=`echo $equipment | cut -d' ' -f11` 
			Expected_throughput=`echo $equipment | cut -d' ' -f12`  
	
			echo "INSERT INTO OpenWRT4 VALUE ('$ip_address', '$name', '$mac_address', '$rx', '$tx', '$rx_bytes','$rx_packets', '$tx_bytes', '$tx_packets', '$Expected_throughput');" | mysql -uwimon -pWiMon wimon

		done < openwrt4.txt	
	fi
	
	sleep 3
done
