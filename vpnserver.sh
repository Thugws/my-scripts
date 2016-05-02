#!/bin/bash
################################################
# To solve trubles with vpn service down status#
# in case you have manualy added routes it could#
# happend periodicaly. To have it working      #
# must be insatalled fping utility             #
################################################
p=$(/usr/bin/fping 10.1.1.1)
echo "$p"
if [ "$p" != "10.1.1.1 is alive"  ]
then
service openvpn restart
  fi




