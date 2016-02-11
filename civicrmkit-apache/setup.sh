#!/bin/sh

# might have been started by civicrm-download-tools?
service apache2 stop

exec /usr/sbin/apache2ctl -DFOREGROUND
