#!/bin/bash

# /etc/config/secure_access_control.sh
# If connect AP, block camera

ssid=`iwgetid | cut -f 2 -d":" | tr -d '"'`
list="Dongwoo,Jaewoong"
flag=0

while :
do
  for i in $ssid
  do
    for j in ssid `echo ${list} | tr ',' '\n'`
    do
      if [ ${i} == ${j} ] ; then
        flag=1
      fi
    done
  done

  if [ $flag == 1 ] ; then
    /home/pi/rud.sh 1> /dev/null
    xmessage -buttons OK:0 -title "[Wimon] Security Alarm" -nearmouse "Camera off" -timeout 5 2> /dev/null
  elif [ $flag == 0 ] ; then
    /home/pi/lud.sh 1> /dev/null
    xmessage -buttons Ok:0 -title "[Wimon] Security Alarm" -default Ok -nearmouse "Logitech devices on" -timeout 5 2> /dev/null
  fi

  sleep 5
done
