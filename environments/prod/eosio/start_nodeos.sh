#!/bin/bash

BACKUP="/root/backup"

/usr/bin/killall -TERM nodeos
/bin/sleep 5

/bin/mkdir -p /root/restore
/bin/tar xvf $BACKUP/latest.tar --strip-components 2 -C /root/restore

if test -f "/root/restore/blocks.log"; then
 /bin/rm -Rf /usr/local/eosio/data
 /bin/mkdir -p /usr/local/eosio/data
 /bin/mkdir -p /usr/local/eosio/data/blocks
 /bin/mv /root/restore/blocks.log /usr/local/eosio/data/blocks

 /usr/bin/screen -d -m -A -S nodeos -L -Logfile /var/log/nodeos.log \
  /usr/local/eosio/bin/nodeos \
  --snapshot=/root/restore/snapshot.bin \
  --data-dir /usr/local/eosio/data \
  --config-dir /usr/local/eosio/etc
else
 /usr/bin/screen -d -m -A -S nodeos -L -Logfile /var/log/nodeos.log \
  /usr/local/eosio/bin/nodeos \
  --data-dir /usr/local/eosio/data \
  --config-dir /usr/local/eosio/etc
fi
