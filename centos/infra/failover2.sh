#!/bin/bash

DEV="enp0s3"
VIP="192.168.2.42 192.168.2.43"

healthcheck(){
    for i in $VIP; do
        if [ -z "`ip addr show $DEV | grep $i`" ]; then
            if [ "200" -ne "`curl -s -I 'http://$i/' | head -n 1 | cut -f 2 -d ' '`" ] ; then
                CIP="$i"
                return 1
            fi
        fi
    done
    return 0
}

ip_takeover(){
    MAC=`ip link show $DEV | egrep -o '([0-9a-f]{2}:){5}[0-9a-f]{2}' | head -n 1 | tr -d :`
    ip addr add $CIP/24 dev $DEV
    send_arp $CIP $MAC 255.255.255.255 ffffffffffff
}

while healthcheck; do
    echo "health ok!"
    sleep 1
done
echo "fail over!"
ip_takeover