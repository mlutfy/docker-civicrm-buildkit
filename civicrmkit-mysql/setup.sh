#!/bin/sh

chown mysql /var/lib/mysql
chown mysql /var/log/mysql

# creates the "mysql" database (users, etc)
# TODO: only do this if the mysql direcory does not exist.
# (or touch a file, that we can check to see if we have done setup already)
mysql_install_db

exec mysqld
