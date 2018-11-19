#!/bin/bash

#get my IP address as visible from the outside world (silently)
#changed from whatismyip.com to ipecho.net, Mar 8th, 2013
if [ $# -ne 3 ]; then
    echo "usage: namecheap_IP_updater.sh aname domain_name ddns_password"
        exit 1
fi

aname=$1    # aname record to update (like @, www, '*')
name=$2     # name of domain to update
password=$3   # password of domain to update

CURRENT_IP="`curl ipecho.net/plain`"
echo "current IP: $CURRENT_IP"
#echo "http://dynamicdns.park-your-domain.com/update?host=$aname&domain=$name&password=$password&ip=$CURRENT_IP"
RESULT=`wget -qO- "http://dynamicdns.park-your-domain.com/update?host=$aname&domain=$name&password=$password&ip=$CURRENT_IP"`
if echo $RESULT | grep -q "<Done>true</Done>";
then
  echo "(namecheap) DDNS IP UPDATED for $aname.$name " `date`
else
  echo "(namecheap) $1 $2 DDNS IP UPDATE FAIL OCCURED at " `date` ": $RESULT"
fi

