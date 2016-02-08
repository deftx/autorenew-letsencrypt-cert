#!/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/X11R6/bin
PDOMAIN=$1

if [ "$PDOMAIN" = "" ]; then
    echo "Please specify a domain"
    echo "[usage] renew-ssl-cert mydomain.com"
    exit 98
fi

CERTPATH="/etc/letsencrypt/live/$PDOMAIN"

/usr/share/letsencrypt/letsencrypt-auto --config /etc/letsencrypt/$PDOMAIN.ini certonly

if [ $? != 0 ]; then
    echo ""
    echo "ERROR: Could not renew certificate!"
    exit 99
fi

cat $CERTPATH/privkey.pem > $CERTPATH/mycpanel.pem
cat $CERTPATH/fullchain.pem >> $CERTPATH/mycpanel.pem

cp $CERTPATH/fullchain.pem /var/cpanel/ssl/exim/myexim.crt
cp $CERTPATH/privkey.pem /var/cpanel/ssl/exim/myexim.key
chown mailnull:mail /var/cpanel/ssl/exim/*

service proftpd restart
service exim restart
service cpanel restart
service dovecot restart

exit 0
