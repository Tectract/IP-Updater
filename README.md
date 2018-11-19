# IP-Updater
Sets DNS entries for domains based on current IP address, Godaddy/Namecheap currently supported


### Note for Godaddy script
usage: godaddy_IP_updater.sh a_record domain_name godaddykey godaddysecret

I generally call this from a chron script as such, against the "*" and @ a_records

*/15 * * * * $SCRIPTDIR/godaddy_IP_updater.sh "*" mydomain.com $GODADDYKEY $GODADDYSECRET >> /var/log/mySiteLogs/IP_Updater.log

*/15 * * * * $SCRIPTDIR/godaddy_IP_updater.sh "*" mydomain.com $GODADDYKEY $GODADDYSECRET >> /var/log/mySiteLogs/IP_Updater.log

make sure /var/logs/mySiteLogs/ is writeable to your user, and defined those ENV vars in .bash_profile, .bashrc, or /etc/environment

### Note for NameCheap Script
usage: namecheap_IP_updater.sh aname domain_name ddns_password

I generally call this from a chron script as such, against the www and @ a_records

*/15 * * * * $SCRIPTDIR/namecheap_IP_updater.sh @ mydomain.com $NAMECHEAPKEY >> /var/log/mySiteLogs/IP_Updater.log

*/15 * * * * $SCRIPTDIR/namecheap_IP_updater.sh www mydomain.com $NAMECHEAPKEY >> /var/log/mySiteLogs/IP_Updater.log

make sure /var/logs/mySiteLogs/ is writeable to your user, and defined those ENV vars in .bash_profile, .bashrc, or /etc/environment





