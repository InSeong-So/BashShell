#!/bin/bash

VIP="192.168.2.42"
DEV="enp0s3"

healthcheck(){
  ping -c 1 -w 1 $VIP > /dev/null
  return $?
}

ip_takeover(){
  MAC=`ip link show $DEV | egrep -o '([0-9a-f]{2}:){5}[0-9a-f]{2}' | head -n 1 | tr -d :`
  ip addr add $VIP/24 dev $DEV
  send_arp $VIP $MAC 255.255.255.255 ffffffffffff
}

while healthcheck; do
  echo "health ok!"
  sleep 1
done

echo "fail over!"
ip_takeover
