#!/bin/bash

# This script is used to check and update your GoDaddy DNS server to the IP address of your current internet connection.
#
# Original PowerShell script by mfox: https://github.com/markafox/GoDaddy_Powershell_DDNS
# Ported to bash by sanctus
# Improved to take command line arguments and output information for log files by pollito
#
# First go to GoDaddy developer site to create a developer account and get your key and secret
#
# https://developer.godaddy.com/getstarted
#
# Be aware that there are 2 types of key and secret - one for the test server and one for the production server
# Get a key and secret for the production server

# Check an A record and a domain are both specified on the command line.

if [ $# -ne 4 ]; then
    echo "usage: godaddy_IP_updater.sh a_record domain_name godaddykey godaddysecret"
        exit 1
fi

# Set A record and domain to values specified by user

name=$1     # name of A record to update
domain=$2   # name of domain to update

# Modify the next two lines with your key and secret

key=$3      # key for godaddy developer API (env vars should be available to script)
secret=$4  # secret for godaddy developer API (env vars should be available to script)

headers="Authorization: sso-key $key:$secret"

#echo $headers

result=$(curl -s -k -X GET -H "$headers" \
 "https://api.godaddy.com/v1/domains/$domain/records/A/$name")

dnsIp=$(echo $result | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
echo $name"."$domain": $(date): dnsIp:" $dnsIp

# Get public ip address there are several websites that can do this.
ret=$(curl -s GET "http://ipinfo.io/json")
currentIp=$(echo $ret | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
echo $name"."$domain": $(date): currentIp:" $currentIp

 if [ "$dnsIp" != "$currentIp" ];
 then
        echo $name"."$domain": $(date): IPs not equal. Updating."
        request='[{"data":"'$currentIp'","ttl":3600}]'
        echo $request
        nresult=$(curl -i -k -s -X PUT \
 -H "$headers" \
 -H "Content-Type: application/json" \
 -d $request "https://api.godaddy.com/v1/domains/$domain/records/A/$name")
        echo $nresult
fi
