#!/bin/bash

DEV="enp0s3"
VIP="192.168.2.42 192.168.2.43"


ip_add(){
    MAC=`ip link show $DEV | egrep -o '([0-9a-f]{2}:){5}[0-9a-f]{2}' | head -n 1 | tr -d :`
    ip addr add $CIP/24 dev $DEV
    send_arp $CIP $MAC 255.255.255.255 ffffffffffff
}

ip_del(){
    ip addr del $1/24 dev $DEV
}

healthcheck(){
    for i in $VIP; do
        if [ "200" -ne "`curl -s -I 'http://$i/' | head -n 1 | cut -f 2 -d ' '`" ] ; then
            if [ -z "`ip addr show $DEV | grep $i`" ]; then
                ip_add $i
            else
                ip_del $i
            fi
        fi
    done
}

while true; do
    healthcheck
    sleep 1
done